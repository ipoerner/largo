#!/bin/sh

set -e

PROJECT=${1:-default}
IMAGE_NAME="build-env-${PROJECT}"
CONTAINER_NAME="build-env-${PROJECT}"
REPOSITORY_PATH=`pwd`
REMOTE_HOME="/home/dockerdev"
REMOTE_WORKDIR="${REMOTE_HOME}/${PROJECT}"
PRIMARY_DNS=`nm-tool | awk '/DNS:/ { print $2 }'`

USER_ID=`id -u`
GROUP_ID=`id -g`

sudo docker run --privileged -e DEV_UID=${USER_ID} -e DEV_GID=${GROUP_ID} --interactive --tty --dns ${PRIMARY_DNS} --name ${CONTAINER_NAME} --volume ${REPOSITORY_PATH}:${REMOTE_WORKDIR} --volume "$SSH_AUTH_SOCK:/tmp/ssh_auth_sock" -e "SSH_AUTH_SOCK=/tmp/ssh_auth_sock" --rm ${IMAGE_NAME}
