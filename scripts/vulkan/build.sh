#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi

# patch -p1 <${PROJECT_DIR}/patches/vulkan-build-static.patch

# build for linux
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR} \
      -DBUILD_TESTS=OFF \
      -DUPDATE_DEPS=ON ..
make -j $(nproc)
make install
