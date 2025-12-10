# https://mesonbuild.com/External-Project-module.html

project('mbedtls', 'c')

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
    'USE_STATIC_MBEDTLS_LIBRARY': true,
    'USE_SHARED_MBEDTLS_LIBRARY': false,
    'LINK_WITH_PTHREAD': true,
    'CMAKE_BUILD_TYPE': 'Release',
})
if host_machine.system() == 'darwin'
  options.add_cmake_defines({
    'CMAKE_OSX_SYSROOT': meson.get_cross_property('cmake_osx_sysroot'),
})
endif

mbedtls = cmake.subproject('mbedtls',
    options: options,
)

mbedtls_dep = mbedtls.dependency('mbedtls')
meson.override_dependency('mbedtls', mbedtls_dep)


mbedcrypto_dep = mbedtls.dependency('mbedcrypto')
meson.override_dependency('mbedcrypto', mbedcrypto_dep)


mbedx509_dep = mbedtls.dependency('mbedx509')
meson.override_dependency('mbedx509', mbedx509_dep)
