#!/bin/sh

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

mkdir -p ${TARGET_DIR}
if [ `echo ${ARCHIVE_FILE} | awk -F'.' '{print $NF}'` -eq  'bz2' ];then
    tar \
    -xjvf ${ARCHIVE_FILE} \
    --strip-components 1 \
    -C ${TARGET_DIR}

else 
    tar \
    -xvf ${ARCHIVE_FILE} \
    --strip-components 1 \
    -C ${TARGET_DIR}

fi
