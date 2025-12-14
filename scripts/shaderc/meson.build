# https://mesonbuild.com/External-Project-module.html

project('shaderc', 'c', 'cpp')

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
    'CMAKE_POLICY_VERSION_MINIMUM': '3.5',
    'BUILD_SHARED_LIBS':'OFF',
    'SHADERC_SKIP_TESTS':'ON',
    'SHADERC_SKIP_SPVC':'ON',
    'SHADERC_SKIP_INSTALL':'ON',
    'SHADERC_SKIP_EXAMPLES':'ON',
    'SPIRV_SKIP_EXECUTABLES':'ON',
    'SPIRV_SKIP_TESTS':'ON',
    'ENABLE_SPIRV_TOOLS_INSTALL':'ON',
    'ENABLE_GLSLANG_BINARIES':'OFF',
    'SPIRV_TOOLS_BUILD_STATIC':'ON',
    'SPIRV_TOOLS_LIBRARY_TYPE':'STATIC',
    'shaderc_combined':true
})

if host_machine.system() == 'darwin'
  options.add_cmake_defines({
    'CMAKE_OSX_SYSROOT': meson.get_cross_property('cmake_osx_sysroot'),
})
endif

shaderc = cmake.subproject('shaderc',
    options: options,
)
message('CMake targets:\n - ' + '\n - '.join(shaderc.target_list()))



shaderc_dep = shaderc.dependency('shaderc_combined-pkg-config')
meson.override_dependency('shaderc_combined-pkg-config', shaderc_dep)
