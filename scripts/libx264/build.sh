#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi

cp ${PROJECT_DIR}/scripts/libx264/meson.* .

# Fix building for arm64
sed -i 's/\-arch arm64//g' configure
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi
meson setup build \
    --cross-file ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}" \
    -Ddefault_library=static
meson compile -C build libx264
meson install -C build
