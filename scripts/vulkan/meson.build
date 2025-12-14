# https://mesonbuild.com/External-Project-module.html

project('vulkan', 'c', 'cpp')

cmake = import('cmake')

cpu = host_machine.cpu()
if cpu == 'amd64'
    arch = 'x86_64'
elif cpu == 'arm64'
    arch = 'arm64'
endif

options = cmake.subproject_options()
options.add_cmake_defines({
    'CMAKE_OSX_ARCHITECTURES': arch,
    'CMAKE_BUILD_TYPE': 'Release',
    'BUILD_SHARED_LIBS':'OFF',
    'VULKAN_HEADERS_INSTALL_DIR':'/root/libmpv-darwin-build/build/intermediate/vulkan-headers_linux-amd64',
    'ENABLE_WERROR':'OFF',
    'USE_GAS': 'ON'
})

if host_machine.system() == 'darwin'
  options.add_cmake_defines({
    'CMAKE_OSX_SYSROOT': meson.get_cross_property('cmake_osx_sysroot'),
})
endif

vulkan = cmake.subproject('vulkan',
    options: options,
)
message('CMake targets:\n - ' + '\n - '.join(vulkan.target_list()))

# asm_offset
vulkan.target('asm_offset')
vulkan.target('loader_asm_gen_files')
