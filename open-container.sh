#!/bin/sh

set -e

PROJECT=${1:-default}
IMAGE_NAME="build-env-${PROJECT}"
CONTAINER_NAME="build-env-${PROJECT}"
REPOSITORY_PATH=`git rev-parse --show-toplevel 2> /dev/null || pwd`
REMOTE_HOME="/home/dockerdev"
REMOTE_WORKDIR="${REMOTE_HOME}/${PROJECT}"
PRIMARY_DNS=`nm-tool | awk '/DNS:/ { print $2 }' | head -n 1`

[ ${PROJECT} != "default" ] && shift

USER_ID=`id -u`
GROUP_ID=`id -g`

# the trick of forwarding the SSH agent into the Docker container comes from Docker issue #6396 on GitHub
# however, it was most probably first introduced by Chris Corbyn <https://gist.github.com/d11wtq/8699521>
sudo docker run --privileged -e DEV_UID=${USER_ID} -e DEV_GID=${GROUP_ID} --interactive --tty --dns ${PRIMARY_DNS} --name ${CONTAINER_NAME} --volume ${REPOSITORY_PATH}:${REMOTE_WORKDIR} --volume "$SSH_AUTH_SOCK:/tmp/ssh_auth_sock" --rm "$@" ${IMAGE_NAME}
