#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi
./utils/git-sync-deps
/usr/bin/python3 /root/libmpv-darwin-build/build/tmp/shaderc_linux-amd64/src/shaderc/utils/add_copyright.py
# cross build with meson
cmake -GNinja -H$SRC_DIR -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR} \
        -DBUILD_SHARED_LIBS=OFF \
        -DSHADERC_SKIP_TESTS=ON \
        -DSHADERC_SKIP_EXAMPLES=ON \
        -DSHADERC_SKIP_EXECUTABLES=OFF
ninja shaderc_combined-pkg-config

ninja install