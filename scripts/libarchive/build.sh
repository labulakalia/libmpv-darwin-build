#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}

# cross build with meson
cp ${PROJECT_DIR}/scripts/libarchive/meson.build ./meson.build
meson setup build_cross \
    --cross-file ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}"
meson compile -C build_cross libarchive
meson install -C build_cross
rm -rf ${OUTPUT_DIR}/{bin,share}


