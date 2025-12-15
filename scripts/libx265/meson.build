# https://mesonbuild.com/External-Project-module.html

project('libx265', 'c', 'cpp','nasm')

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
    
    'ENABLE_ASSEMBLY': 'ON',
    'CC_HAS_FAST_MATH': 'OFF',
    
    'CMAKE_CXX_FLAGS': '-Wno-register',
    'CMAKE_C_FLAGS': '-Wno-register',
})

options.add_cmake_defines({
    'EXTRA_CFLAGS': '',
    'EXTRA_CXXFLAGS': '',
})

# 如果上述依然无效，尝试强制拦截全局 Flags
# 某些版本的 Meson 会把 CMAKE_CXX_FLAGS 传给 NASM
options.add_cmake_defines({
    'CMAKE_CXX_FLAGS': '-Wno-register', # 确保这里没有 -ffast-math
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
