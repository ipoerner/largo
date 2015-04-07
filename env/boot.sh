#!/bin/sh

# manual user mapping, inspired by <http://chapeau.freevariable.com/2014/08/docker-uid.html>

ORIGPASSWD=$(cat /etc/passwd | grep dockerdev)
ORIG_UID=$(echo $ORIGPASSWD | cut -f3 -d:)
ORIG_GID=$(echo $ORIGPASSWD | cut -f4 -d:)

DEV_UID=${DEV_UID:=$ORIG_UID}
DEV_GID=${DEV_GID:=$ORIG_GID}

ORIG_HOME=$(echo $ORIGPASSWD | cut -f6 -d:)

sed -i -e "s/:$ORIG_UID:$ORIG_GID:/:$DEV_UID:$DEV_GID:/" /etc/passwd
sed -i -e "s/dockerdev:x:$ORIG_GID:/dockerdev:x:$DEV_GID:/" /etc/group

chown -R ${DEV_UID}:${DEV_GID} ${ORIG_HOME}

# git completion

/bin/cat <<EOM >>${ORIG_HOME}/.bashrc

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
EOM

exec login -f dockerdev
