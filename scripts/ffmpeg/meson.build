# https://mesonbuild.com/External-Project-module.html

project('ffmpeg', 'c', 'cpp', 'objc')

mod = import('unstable-external_project')

# build binaries
c = meson.get_compiler('c')
cpp = meson.get_compiler('cpp')
objc = meson.get_compiler('objc')
nm = find_program('nm')
ar = find_program('ar')
strip = find_program('strip')
pkg_config = find_program('pkg-config')

# build options
c_args = get_option('c_args')
cpp_args = get_option('cpp_args')
objc_args = get_option('objc_args')
c_link_args = get_option('c_link_args')

# parameters
variant = get_option('variant')
flavor = get_option('flavor')


# options
disable_all_options = [
    '--disable-outdevs',
    '--disable-filters',
    '--disable-muxers',
    '--disable-encoders',
    '--disable-decoders',
    '--disable-demuxers',
    '--disable-protocols',
    '--disable-parsers',
    '--disable-programs',
    '--disable-debug',
    '--disable-doc',
]


common_options = [
    '--prefix=@PREFIX@',
    '--enable-small', # reduce libs size
    '--pkg-config=pkg-config',
    '--pkg-config-flags=--static',
    '--enable-gpl',
    '--enable-libx264',
    '--enable-libx265',
    '--enable-libfreetype',
    '--enable-neon',
    '--enable-zlib',
    '--enable-libxml2',
    '--enable-libdav1d',
    '--enable-libvorbis',
    '--enable-hwaccels',
    '--enable-libvpx',
    '--enable-libdvdnav',
    '--enable-libdvdread',
    '--enable-libbluray',
    '--enable-decoder=*sub*,movtext,*web*,aac*,ac3*,eac3*,alac*,ape,ass,av1*,ccaption,cfhd,cook,dca,dnxhd,exr,truehd,*yuv*,flv,flac,gif,h26[3-4]*,hevc*,hap,mp[1-3]*,prores*,*[mj]peg*,mlp,mpl2,nellymoser,opus,pcm*,qtrle,*png*,tiff,rawvideo,sami,srt,ssa,v210*,vc1*,vorbis,vp[6-9]*,wm*,wrapped_avframe,rv*,ffv*',
    '--enable-demuxer=*sub*,*ac3,*ac,*avs*,*[mj]peg*,*vc*,*web*,au,ape,ass,av[1i],concat,dnxhd,dts*,*dash*,*flv,gif,hls,h264,kux,matroska,mov,mp3,mxf,obu,ogg,pcm*,rawvideo,rt*p,spdif,srt,v210*,wav,*pipe,image2,,mlv,nsv,nut',
    '--enable-encoder=libx26*,aac,cfhd,dnxhd,exr,ff*,flv,*yuv*,gif,h26[3-4]*,av1*,hevc*,mjpeg*,*png,opus,pcm*,prores*,rawvideo,spdif,speedhq,*jpeg,*png,tiff,vp[8-9]*,wrapped_avframe,*nvenc,*qsv,*v4l2m2m,*vaapi,vorbis',
    '--enable-muxer=*jpeg,dnxhd,fifo,flv,gif,hls,h264,hevc,image2,mov,mp4,mpegts,matroska,null,og*,pcm*,rawvideo,rt*,spdif,*pipe,*segment,webm,wav,dash,nu*',
    '--enable-protocol=cache,concat*,crypto*,data,fd,*file,ftp,h*,i*,pipe,rt*,s*,t*,u*',
    '--enable-filter=drawtext,*null*,afade,*fifo,*format,*resample,aeval,atempo,pan,crop,eq*,framerate,hw*,loudnorm,scale,volume,yadif*,*movie,overlay,allrgb,allyuv,*bars,color,test*,*key,draw*,*_qsv,*_vaapi,*v4l2*,equalizer'
]


macos_option = [
    '--enable-videotoolbox',
    '--enable-vda',
]

macos_option = [
    '--enable-videotoolbox',
    '--disable-avdevice'
]

linux_option = [
    '--enable-libpulse',
    
    '--enable-vaapi',
    '--enable-vdpau',
    '--enable-libdrm',
]



# disable all option
options = disable_all_options

# common
options += common_options
options += linux_option

p = mod.add_project('configure',
    configure_options : options,
    cross_configure_options: [
        '--enable-cross-compile',
        '--target-os=@0@'.format(host_machine.system()),
        '--arch=@0@'.format(host_machine.cpu_family()),

        '--nm=@0@'.format(nm.path()),
        '--ar=@0@'.format(ar.path()),
        '--as=@0@'.format(''.join(c.cmd_array())),
        '--strip=@0@'.format(strip.path()),
        '--cc=@0@'.format(''.join(c.cmd_array())),
        '--cxx=@0@'.format(''.join(cpp.cmd_array())),
        '--objcc=@0@'.format(''.join(objc.cmd_array())),
        '--ld=@0@'.format(''.join(c.cmd_array())),
        '--pkg-config=@0@'.format(pkg_config.path()),

        '--host-cc=@0@'.format(''.join(c.cmd_array())),
        '--host-ld=@0@'.format(''.join(c.cmd_array())),

        '--extra-cflags=@0@'.format(' '.join(c_args)),
        '--extra-cxxflags=@0@'.format(' '.join(cpp_args)),
        '--extra-objcflags=@0@'.format(' '.join(objc_args)),
        '--extra-ldflags=@0@'.format(' '.join(c_link_args)),
    ],
    verbose: true,
)

libavfilter_dep = p.dependency('avfilter')
libswscale_dep = p.dependency('swscale')
libavcodec_dep = p.dependency('avcodec')
libavformat_dep = p.dependency('avformat')
libavutil_dep = p.dependency('avutil')
libswresample_dep = p.dependency('swresample')

meson.override_dependency('libavfilter', libavfilter_dep)
meson.override_dependency('libswscale', libswscale_dep)
meson.override_dependency('libavcodec', libavcodec_dep)
meson.override_dependency('libavformat', libavformat_dep)
meson.override_dependency('libavutil', libavutil_dep)
meson.override_dependency('libswresample', libswresample_dep)
