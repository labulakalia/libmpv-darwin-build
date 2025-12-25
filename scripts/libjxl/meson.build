# https://mesonbuild.com/External-Project-module.html

project('libjxl', 'c', 'cpp')

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
    'BUILD_BINARY': 'ON',
    'BUILD_SHARED_LIBS':'OFF',
    'BUILD_STATIC': 'ON',
    'BUILD_TESTING': 'OFF',
    'JPEGXL_ENABLE_BENCHMARK': 'OFF',
    'JPEGXL_ENABLE_OPENEXR': 'OFF',
    'JPEGXL_ENABLE_PLUGINS': 'OFF',
    'JPEGXL_ENABLE_VIEWERS': 'OFF',
    'JPEGXL_ENABLE_JPEGLI': 'OFF',
	'JPEGXL_ENABLE_JPEGLI_LIBJPEG':'OFF',
    'JPEGXL_FORCE_SYSTEM_GTEST': 'OFF',
    'JPEGXL_ENABLE_TESTS': 'OFF',
    'JPEGXL_VERSION': 'v0.11.1',
    'BROTLI_CLI': 'OFF',
    'JPEGXL_ENABLE_TOOLS': 'OFF',
    'JPEGXL_FORCE_SYSTEM_HWY': 'OFF',
    'JPEGXL_FORCE_SYSTEM_BROTLI': 'OFF',
    'JPEGXL_ENABLE_THREAD': 'OFF',
    'JPEGXL_STATIC': 'ON',
    'JPEGXL_ENABLE_EXAMPLES': 'OFF'
})

if host_machine.system() == 'darwin'
  options.add_cmake_defines({
    'CMAKE_OSX_SYSROOT': meson.get_cross_property('cmake_osx_sysroot'),
})
endif

libjxl = cmake.subproject('libjxl',
    options: options,
)

message('CMake targets:\n - ' + '\n - '.join(libjxl.target_list()))


libjxl_dep = libjxl.dependency('jxl')
meson.override_dependency('jxl', libjxl_dep)
