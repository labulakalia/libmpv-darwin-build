# https://mesonbuild.com/External-Project-module.html

project('libass', 'c')

mod = import('unstable-external_project')

configure_options = [
    '--prefix=@PREFIX@',
    '--enable-static',
    '--enable-shared=no',
    '--enable-fast-install',
    '--disable-dependency-tracking',
    '--disable-test',
    '--disable-compare',
    '--disable-profile',
    '--disable-fuzz',
    '--disable-directwrite',
    '--disable-libunibreak',
    '--disable-require-system-font-provider',
    '--disable-asm',
    '--disable-large-tiles',
    '--with-pic',
    '--with-aix-soname=aix',
    '--without-gnu-ld',
]

if host_machine.system() == 'darwin'
    configure_options += [
        '--enable-coretext',
        '--disable-fontconfig',
    ]
else
    configure_options += [
        '--disable-coretext',
        '--enable-fontconfig',
    ]
endif

p = mod.add_project('configure',
    configure_options : configure_options,
    verbose: true,
)

libass_dep = p.dependency('libass')
meson.override_dependency('libass', libass_dep)
