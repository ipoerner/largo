#!/bin/sh

set -e

PROJECT=${1:-default}
VISIBILITY=${2:-public}
IMAGE_NAME="build-env-${PROJECT}"
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

mkdir -p ${SCRIPTPATH}/${VISIBILITY}/${PROJECT}/env
cp -f ${SCRIPTPATH}/env/* ${SCRIPTPATH}/${VISIBILITY}/${PROJECT}/env/

mkdir -p ${SCRIPTPATH}/${VISIBILITY}/${PROJECT}/config
(cd ${SCRIPTPATH}/config
for file in `ls -AL -I .gitignore`; do
    cp -f $file ${SCRIPTPATH}/${VISIBILITY}/${PROJECT}/config/
done
)

sudo docker build --tag ${IMAGE_NAME} --force-rm ${SCRIPTPATH}/${VISIBILITY}/${PROJECT}
