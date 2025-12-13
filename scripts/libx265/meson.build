# https://mesonbuild.com/External-Project-module.html

project('libx265', 'c', 'cpp')

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
    'ENABLE_CLI': 'OFF',
    'ENABLE_SHARED': 'OFF',
    'ENABLE_PIC': 'OFF',
    # 强制启用高位深度 (HBD)，这是 10bit 和 12bit 的基础
    'HIGH_BIT_DEPTH': 'ON',
    
    'CMAKE_ASM_FLAGS': '',
    'CMAKE_POSITION_INDEPENDENT_CODE': 'OFF',
    'CC_HAS_FAST_MATH': 'OFF',
    'CC_HAS_FNO_EXCEPTIONS_FLAG': 'OFF'
})


if host_machine.system() == 'darwin'
  options.add_cmake_defines({
    'CMAKE_OSX_SYSROOT': meson.get_cross_property('cmake_osx_sysroot'),
})
endif

libx265 = cmake.subproject('libx265',
    options: options,
)

message('CMake targets:\n - ' + '\n - '.join(libx265.target_list()))
libx265_dep = libx265.dependency('x265-static')
meson.override_dependency('x265-static', libx265_dep)
