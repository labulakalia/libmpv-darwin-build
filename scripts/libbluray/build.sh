#!/bin/bash

set -e # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi
rm -rf contrib/libudfread
tar -zxf ${DOWNLOADS_DIR}/libudfread-1.2.0.tar.gz -C contrib
mv contrib/libudfread-1.2.0 contrib/libudfread 
meson setup build \
    --cross-file ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}" \
    -Ddefault_library=static -Ddebug=false
meson compile -C build
meson install -C build
