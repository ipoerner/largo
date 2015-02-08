#!/bin/sh

set -e

PROJECT=${1:-default}
IMAGE_NAME="build-env-${PROJECT}"
SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

mkdir -p ${SCRIPTPATH}/${PROJECT}/env
cp -f ${SCRIPTPATH}/env/* ${SCRIPTPATH}/${PROJECT}/env/

mkdir -p ${SCRIPTPATH}/${PROJECT}/config
(cd ${SCRIPTPATH}/config
for file in `ls -AL`; do
    cp -f $file ${SCRIPTPATH}/${PROJECT}/config/
done
)

sudo docker build --tag ${IMAGE_NAME} --force-rm ${SCRIPTPATH}/${PROJECT}
