#!/bin/bash

set -e # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi

NAME=$(basename ${OUTPUT_FILE} .tar.gz)

cp -R ${DEPS} ${NAME}
tar -czvf ${NAME}.tar.gz ${NAME}
