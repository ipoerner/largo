#!/bin/sh

# manual user mapping, inspired by <http://chapeau.freevariable.com/2014/08/docker-uid.html>

export ORIGPASSWD=$(cat /etc/passwd | grep dockerdev)
export ORIG_UID=$(echo $ORIGPASSWD | cut -f3 -d:)
export ORIG_GID=$(echo $ORIGPASSWD | cut -f4 -d:)

export DEV_UID=${DEV_UID:=$ORIG_UID}
export DEV_GID=${DEV_GID:=$ORIG_GID}

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

cd /home/dockerdev
exec su dockerdev
