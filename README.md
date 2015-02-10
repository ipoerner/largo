# Containers

A few scripts which assist with the management of redistributable development
environments using Docker.

Implements rudimentary user-mapping between the host system and the container,
as well as SSH agent forwarding for simplified SSH key management.

## Usage

    build-image.sh <project> (private|public)

Builds a new Docker image for a given `project`. Each project consists of a
`Dockerfile` that is located in a directory carrying the name of the project
and which must itself be located in either of the two folders `public/` or
`private/`, depending on whether or not you want to share the project and its
corresponding `Dockerfile` with others.

The default privacy setting is "public", so you may omit the last parameter. The
script can be invoked from anywhere.

    open-container.sh <project>

Opens a temporary Docker container which will bring you to your projects build
environment. This script must be invoked from within the project repository,
as it will use Git to determine the project root and mount this to your home
directory within the Docker container.

If your project is not a Git repository, it will use `pwd` to determine the
current path. Thus, you'll need to explicitly change to the directory you want
to see mounted in the container.

## Directory structure

* config

  Put links to your configuration files here (i.e. `~/.gitconfig`). These will
be copied to the home directory within the Docker container.

* env

  Contains scripts required for running the development environments.

* private

  Contains a sub-directory for each of your private projects. None of these will
be tracked by Git.

* public

  Contains a sub-directory for each of your public projects. Those will be
tracked by Git.

* build-image.sh

  This scripts builds a new Docker image for a given project.

* open-container.sh

  This script spawns a new Docker container for a given project, mounts the
project sources tree to the home directory within the Docker container and
spawns a new shell. Invoke this script from within your project repository path.

* Dockerfile.template

  A Dockerfile template for your projects.

* README.md

  This file.
