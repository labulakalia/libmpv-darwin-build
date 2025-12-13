#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error
MAKEFLAGS=" -j -l $(nproc)"
cd ${SRC_DIR}

mkdir -p build/dist/{lib,include}
mkdir -p build/dist/lib/pkgconfig



if [[ $OS == "linux" && $ARCH == "amd64" ]];then
    cd build/linux || exit
    rm -rf 8bit 10bit 12bit 2>/dev/null
    mkdir -p 8bit 10bit 12bit
    cd 12bit || exit
    cmake ../../../source -DCMAKE_INSTALL_PREFIX="${OUTPUT_DIR}" -DENABLE_SHARED=OFF -DBUILD_SHARED_LIBS=OFF -DHIGH_BIT_DEPTH=ON -DENABLE_HDR10_PLUS=ON -DEXPORT_C_API=OFF -DENABLE_CLI=OFF -DMAIN12=ON
    make $MAKEFLAGS
    cd ../10bit || exit
    cmake ../../../source -DCMAKE_INSTALL_PREFIX="${OUTPUT_DIR}" -DENABLE_SHARED=OFF -DBUILD_SHARED_LIBS=OFF -DHIGH_BIT_DEPTH=ON -DENABLE_HDR10_PLUS=ON -DEXPORT_C_API=OFF -DENABLE_CLI=OFF
    make $MAKEFLAGS
    cd ../8bit || exit
    ln -sf ../10bit/libx265.a libx265_main10.a
    ln -sf ../12bit/libx265.a libx265_main12.a
    cmake ../../../source -DCMAKE_INSTALL_PREFIX="${OUTPUT_DIR}" -DENABLE_SHARED=OFF -DBUILD_SHARED_LIBS=OFF -DEXTRA_LIB="x265_main10.a;x265_main12.a;-ldl" -DEXTRA_LINK_FLAGS=-L. -DLINKED_10BIT=ON -DLINKED_12BIT=ON
    make $MAKEFLAGS

    mv libx265.a libx265_main.a

    ar -M <<EOF
CREATE  ${SRC_DIR}/build/dist/lib/libx265.a
ADDLIB libx265_main.a
ADDLIB libx265_main10.a
ADDLIB libx265_main12.a
SAVE
END
EOF
    cp x265_config.h ${SRC_DIR}/build/dist/include/
    cp x265.pc ${SRC_DIR}/build/dist/lib/pkgconfig
fi

cd ${SRC_DIR}
cp source/x265.h ${SRC_DIR}/build/dist/include/
mkdir -p ${OUTPUT_DIR}
cp -rf build/dist/* ${OUTPUT_DIR}/
