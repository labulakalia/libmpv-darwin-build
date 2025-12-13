#!/bin/sh

set -e # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error
mkdir -p build/intermediate/libdvdcss_linux-amd64
cd ${SRC_DIR}

meson setup build \
    --cross-file ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}" \
    -Ddefault_library=static -Denable_docs=false -Denable_examples=false
meson compile -C build
meson install -C build
