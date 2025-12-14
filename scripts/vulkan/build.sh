#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi

git am --3way ${PROJECT_DIR}/patches/vulkan-build-static.patch

# build for linux
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${OUTPUT_DIR} \
      -DBUILD_TESTS=OFF \
      -DBUILD_SHARED_LIBS=OFF -DENABLE_WERROR=OFF -DBUILD_STATIC_LOADER=ON \
      -DUPDATE_DEPS=ON ..
make -j $(nproc)
make install
