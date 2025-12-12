#!/bin/sh

set -ex # exit immediately if a command exits with a non-zero status
set -u # treat unset variables as an error

cd ${SRC_DIR}

rm -rf ./3rdparty
mkdir -p ./3rdparty 

tar -xzvf "${DOWNLOADS_DIR}/fast_float-5.2.0.tar.gz" -C ./3rdparty/
mv ./3rdparty/fast_float-5.2.0 ./3rdparty/fast_float

tar -xzvf "${DOWNLOADS_DIR}/glad-2.0.4.tar.gz" -C ./3rdparty/
mv ./3rdparty/glad-2.0.4 ./3rdparty/glad

tar -xzvf "${DOWNLOADS_DIR}/jinja-3.1.2.tar.gz" -C ./3rdparty/
mv ./3rdparty/jinja-3.1.2 ./3rdparty/jinja


tar -xzf "${DOWNLOADS_DIR}/markupsafe-2.1.2.tar.gz" -C ./3rdparty/
mv ./3rdparty/MarkupSafe-2.1.2 ./3rdparty/markupsafe

tar -xzvf "${DOWNLOADS_DIR}/Vulkan-Headers-1.4.336.tar.gz" -C ./3rdparty/
mv ./3rdparty/Vulkan-Headers-1.4.336 ./3rdparty/Vulkan-Headers

meson setup build \
    --cross-file ${PROJECT_DIR}/cross-files/${OS}-${ARCH}.ini \
    --prefix="${OUTPUT_DIR}" \
    -Ddemos=false \
    -Dtests=false \
    -Dvulkan=enabled \
    --default-library=static 

meson compile -C build
meson install -C build
