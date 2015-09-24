#!/bin/sh

set -e

create_user_largo() {
    TARGET_UID=$(stat -c%u ${LARGO_WORKDIR})
    TARGET_GID=$(stat -c%g ${LARGO_WORKDIR})

    groupadd \
        --gid ${TARGET_GID} \
        largo

    useradd \
        --system \
        --shell /bin/bash \
        --home /home/largo \
        --gid largo \
        --groups staff,sudo \
        --uid $TARGET_UID \
        --password $(mkpasswd largo) \
        largo \
        2> /dev/null--

    chown --recursive ${TARGET_UID}:${TARGET_GID} /home/largo

    echo "cd ${LARGO_WORKDIR}" >> /home/largo/.profile
}

getent passwd largo > /dev/null || create_user_largo

exec login -f largo
