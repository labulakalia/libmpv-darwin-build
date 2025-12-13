#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

mkdir -p ${TARGET_DIR}
if $(echo ${ARCHIVE_FILE}) | grep -q 'bz2$';then
    tar \
    -xjvf ${ARCHIVE_FILE} \
    --strip-components 1 \
    -C ${TARGET_DIR}
elif $(echo ${ARCHIVE_FILE}) | grep -q 'xz$';then
    tar \
    -xzvf ${ARCHIVE_FILE} \
    --strip-components 1 \
    -C ${TARGET_DIR}
else 
    tar \
    -xvf ${ARCHIVE_FILE} \
    --strip-components 1 \
    -C ${TARGET_DIR}
fi
