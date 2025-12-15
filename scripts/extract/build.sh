#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error
rm -rf ${TARGET_DIR}
mkdir -p ${TARGET_DIR}
if echo ${ARCHIVE_FILE} | grep -q 'bz2$';then
    tar \
    -xjf ${ARCHIVE_FILE} \
    --strip-components 1 \
    -C ${TARGET_DIR}
elif echo ${ARCHIVE_FILE} | grep -q 'xz$';then
    tar \
    -xf ${ARCHIVE_FILE} \
    --strip-components 1 \
    -C ${TARGET_DIR}
else 
    tar \
    -xzf ${ARCHIVE_FILE} \
    --strip-components 1 \
    -C ${TARGET_DIR}
fi
