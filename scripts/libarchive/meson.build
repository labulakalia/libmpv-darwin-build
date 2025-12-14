# https://mesonbuild.com/External-Project-module.html

project('libarchive', 'c')

mod = import('unstable-external_project')

configure_options = [
    '--prefix=@PREFIX@',
    '--enable-static',
    '--enable-shared=no',
    '--enable-fast-install',
    '--disable-bsdtar',
    '--disable-bsdcat',
    '--disable-bsdcpio',
    '--disable-bsdunzip',
    '--disable-dependency-tracking',
    '--without-bz2lib',
    '--without-lz4',
    '--without-lzma',
    '--without-lzo2',
    '--without-nettle',
    '--without-openssl',
    '--without-xml2',
    '--without-zlib',
    '--without-zstd',
    '--disable-acl',
    '--disable-xattr',
    '--enable-posix-regex-lib=libc',
    '--with-mbedtls',

]



p = mod.add_project('configure',
    configure_options : configure_options,
    verbose: true,
)

libarchive_dep = p.dependency('libarchive')
meson.override_dependency('libarchive', libarchive_dep)
