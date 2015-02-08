# Containers

A few scripts which assist with the management of redistributable development
environments using Docker.

Implements rudimentary user-mapping between the host system and the container,
as well as SSH agent forwarding for simplified SSH key management.

Directory structure:

* bin/

  Put links to the two main script files here and add it to your path.

* config

  Put links to your private configuration files here. They will be copied into
your Docker containers' home directory.

* env

  Contains boot scripts required within your development environments.

* private

  Contains a number of folders, each of which represents a private development
environment with its corresponding Dockerfile. None of those will be tracked by
Git.

* public

  Contains a number of folders, each of which represents a public development
environment with its corresponding Dockerfile.

* build-image.sh

  This scripts builds a new image for a give project.

* open-container.sh

  This script spawns a new container for a given project, mounts the project
sources to the containers' home directory and spawns a new shell. Invoke this
from within your project root directory.

* Dockerfile.template

  A Dockerfile template for your projects.

* README.md

  This file.
