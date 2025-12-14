#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi
./utils/git-sync-deps
/usr/bin/python3 ./utils/add_copyright.py
# cross build with meson
cmake -GNinja -H$SRC_DIR -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR} \
        -DSHADERC_SKIP_TESTS=ON \
        -DSHADERC_SKIP_INSTALL=OFF \
        -DSHADERC_SKIP_EXAMPLES=ON \
        -DSPIRV_SKIP_EXECUTABLES=ON \
        -DSPIRV_SKIP_TESTS=ON \
        -DENABLE_SPIRV_TOOLS_INSTALL=ON \
        -DENABLE_GLSLANG_BINARIES=OFF \
        -DSPIRV_TOOLS_BUILD_STATIC=ON
ninja shaderc_combined-pkg-config

ninja install
