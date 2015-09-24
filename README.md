# Largo

A few scripts which assist with the management of custom build environments
using Docker.

Implements rudimentary user-mapping between the host system and the container,
as well as SSH agent forwarding for simplified SSH key management.

## <a name="usage"></a>Usage

    largo build --base <base-image>

Creates a local Largo base image to use as a base for your projects. These base
images just add some custom features on top of existing public base images.

You'll find the corresponding Dockerfiles under `base/Dockerfile.*`, where the
file extension identifies the base image name to use.

Building a Largo base image is the first step before doing anything else.

    largo build [<project-name>]

Creates a local Largo image that represents your custom build environment. The
project name will be either derived automatically from your current working
directory, or you can supersede it with something else.

In any case, your current working directory must contain a Dockerfile that uses
an existing Largo base image as a base.

    largo run <project-name> [<args>]

Spawns a Docker container and brings you to your custom build environment. This
script must be invoked from within the projects source repository, as it will
use Git to determine the project root and mount this to your home directory
within the Docker container.

If your project is not a Git repository, it will use `pwd` to determine the
current path. Thus, you'll first need to explicitly change to the exact
directory you want to see mounted in the container.

Once the container is running, you'll end up with a login shell of the `largo`
user. This user is basically a mapping of your host's user ID to a local user
who has sudo rights and uses the password 'largo'. All files created locally by
the `largo` user will be owned by your original user on the host system.

You can also append a list of additional arguments to pass to the `docker run`
command if you like – for instance, for removing the container immediately
after logout with `--rm`.

    largo attach <project-name>

Use this command to reconnect to a container that you previously logged out
from. Containers normally persist after logging out in order to keep the home
directory of the 'largo' user intact.

    largo destroy <project-name>

Destroy the container associated with your project. This will not affect your
project directory, but it will purge the home directory of the 'largo' user
along with it.

## <a name="dirstruct"></a>Directory Structure

* base

  Contains a number of Dockerfiles to build the Largo base images from.

* bin

  Executables (also see [Usage](#usage)) – add these to your `$PATH`.

  * largo

    Main executable that wraps the commands described below.

  * largo-attach

    Restarts the Docker container for an existing project and attaches to it.
    Invoke this script from somewhere within your projects source repository.

  * largo-build

    Creates the Largo base images to use as a base for your project images, or
    builds the project images. In the latter case, the command must be invoked
    from within your project path.

  * largo-destroy

    Removes the Docker container for an existing project along with all volumes.
    Invoke this script from somewhere within your projects source repository.

  * largo-run

    Spawns a new Docker container for a given project, mounts the project source
    tree to the your home directory within the Docker container and brings you
    to a login shell. Invoke this script from somewhere within your projects
    source repository.

* config

  Put links to your configuration files here (i.e. `~/.gitconfig`). These will
  be mirrored on your Docker containers home directory.

  You can also provide additional SSH keys which are not installed on your host
  system by putting them into `config/.ssh`.

* examples

  A few example projects and a template Dockerfile to use for your own projects.

## License

Please see [LICENSE](/LICENSE) for licensing details.

## Links

[https://www.docker.com](https://www.docker.com)
