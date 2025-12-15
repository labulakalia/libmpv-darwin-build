#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi

patch -p1 <${PROJECT_DIR}/patches/ltmain-target-passthrough.patch

echo $SRC_DIR
# Fix building on modern macOS
sed  's/\-force_cpusubtype_ALL//g' configure > configure.bak
mv configure.bak configure

cp ${PROJECT_DIR}/scripts/libvorbis/meson.* .

meson setup build \
    --cross-file ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}" |
    tee configure.log

meson compile -C build libvorbis
meson install -C build
