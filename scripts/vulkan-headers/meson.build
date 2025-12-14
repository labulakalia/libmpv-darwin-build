# https://mesonbuild.com/External-Project-module.html

project('vulkan-headers', 'c', 'cpp')

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
    'VULKAN_HEADERS_ENABLE_MODULE': 'OFF'
})

if host_machine.system() == 'darwin'
  options.add_cmake_defines({
    'CMAKE_OSX_SYSROOT': meson.get_cross_property('cmake_osx_sysroot'),
    })
endif



vulkan_headers = cmake.subproject('vulkan-headers',
    options: options,
)
message('CMake targets:\n - ' + '\n - '.join(vulkan_headers.target_list()))
vulkan_headers_dep = vulkan_headers.dependency('Vulkan-Headers')
meson.override_dependency('Vulkan-Headers', vulkan_headers_dep)
