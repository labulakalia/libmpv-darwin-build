#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi

bash subprojects/libjxl/deps.sh
# cross build with meson
cp ${PROJECT_DIR}/scripts/libjxl/meson.build ./meson.build
export JPEGXL_VERSION=v0.11.1
meson setup build_cross \
    --cross-file ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}" -Dc_link_args="-lpthread"
meson compile -C build_cross
meson install -C build_cross

mkdir -p ${OUTPUT_DIR}/lib/pkgconfig

cp build_cross/subprojects/libjxl/__CMake_build/lib/*.pc ${OUTPUT_DIR}/lib/pkgconfig/
cp -rf build_cross/subprojects/libjxl/__CMake_build/lib/include ${OUTPUT_DIR}/
