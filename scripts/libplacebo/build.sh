#!/bin/bash

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}
if [[ -d ${OUTPUT_DIR} ]];then
    echo "already exists,skip"
    exit 0
fi

rm -rf ./3rdparty
mkdir -p ./3rdparty 

tar -xzf "${DOWNLOADS_DIR}/fast_float-5.2.0.tar.gz" -C ./3rdparty/
mv ./3rdparty/fast_float-5.2.0 ./3rdparty/fast_float

tar -xzf "${DOWNLOADS_DIR}/glad-2.0.4.tar.gz" -C ./3rdparty/
mv ./3rdparty/glad-2.0.4 ./3rdparty/glad

tar -xzf "${DOWNLOADS_DIR}/jinja-3.1.2.tar.gz" -C ./3rdparty/
mv ./3rdparty/jinja-3.1.2 ./3rdparty/jinja


tar -xzf "${DOWNLOADS_DIR}/markupsafe-2.1.2.tar.gz" -C ./3rdparty/
mv ./3rdparty/MarkupSafe-2.1.2 ./3rdparty/markupsafe

tar -xzf "${DOWNLOADS_DIR}/Vulkan-Headers-1.4.336.tar.gz" -C ./3rdparty/
mv ./3rdparty/Vulkan-Headers-1.4.336 ./3rdparty/Vulkan-Headers

cp ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini /tmp/${OS}-${ARCH}.ini
if grep '\-std=c++14' /tmp/${OS}-${ARCH}.ini;then
    sed -i 's/-std=c++14/-std=c++17/g'  /tmp/${OS}-${ARCH}.ini
fi 

meson setup build \
    --cross-file /tmp/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}" \
    -Ddemos=false \
    -Dprefer_static=true \
    -Dtests=false \
    -Dvulkan=enabled \
    -Ddebug=false \
    -Dglslang=enabled \
    -Ddefault_library=static \
    -Dshaderc=enabled

meson compile -C build
meson install -C build
