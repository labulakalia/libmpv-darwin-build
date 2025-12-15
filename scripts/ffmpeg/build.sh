#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi

env


cp ${PROJECT_DIR}/scripts/ffmpeg/meson.* .

meson setup build \
    --cross-file ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}" \
    -Dvariant=${VARIANT} \
    -Dflavor=${FLAVOR} -Dc_link_args='-lxml2' \
    -Dc_args="-I/opt/homebrew/opt/gettext/include" \
    -Dc_link_args="-L/opt/homebrew/opt/gettext/lib" \
    -Ddebug=false |
    tee configure.log

meson compile -C build ffmpeg

# manual install to preserve symlinks (meson install -C build)
mkdir -p "${OUTPUT_DIR}"
cp -R build/dist"${OUTPUT_DIR}"/* "${OUTPUT_DIR}"/

# copy configure.log
cp configure.log "${OUTPUT_DIR}"/share/ffmpeg/
