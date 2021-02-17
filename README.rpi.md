## MDK: Multimedia Development Kit

### Features
- Simple and powerful API set
- Cross platform: Windows, UWP, Linux, macOS, Android, iOS, Raspberry Pi
- Hardware accelerated decoding and 0-copy GPU rendering for all supported platforms
- OpenGL, D3D11, Vulkan and Metal rendering w/ or w/o user provided context
- Integrated with any gui toolkit or app via OpenGL, D3D11, Vulkan and Metal (OBS, Qt, SDL, glfw, SFML and native ui etc.) easily
- Seamless/Gapless media and bitrate switch for any media
- Configurable FFmpeg runtime libraries.
- HDR rendering in GPU
- Optimized Continuous seeking. As fast as mpv, but much lower cpu, memory and gpu load. Suitable for timeline preview

## FFmpeg Runtime Lookup
FFmpeg modules can be specified via environment var AVUTIL_LIB, AVCODEC_LIB, AVFORMAT_LIB, AVFILTER_LIB, SWRESAMPLE_LIB, SWSCALE_LIB, or SetGlobalOption() with key avutil_lib, avcodec_lib, avformat_lib, swresample_lib, swscale_lib, avfilter_lib. For example `SetGlobalOption("avutil_lib", "/opt/lib/libavutil.so.56")`

If ffmpeg any module is not set, it's searched in the following order
- current module dir > framework dir(apple) > system default search dir
- single ffmpeg library > ffmpeg modules w/ version > ffmpeg modules w/o version


## About SDK for Raspberry Pi
SDK is cross built by clang 8.0 with
- cmake toolchain file https://github.com/wang-bin/cmake-tools/blob/master/raspberry-pi.clang.cmake
- sysroot: https://sourceforge.net/projects/avbuild/files/raspberry-pi/raspberry-pi-sysroot.tar.xz/download
- ffmpeg: https://sourceforge.net/projects/avbuild/files/raspberry-pi/ffmpeg-master-raspberry-pi-clang-lite.tar.xz/download
- libc++ 9.0

SDK can be used by any C or C++11 compiler, e.g. g++, clang

pi 4: ALSA_DEVICE=sysdefault

clang >= 9 result dso can not be loaded on rpi1, maybe there is a bug in lld

### Runtime Requirements
- glibc 2.12 (ubuntu 12.04)
- gapless playback hardware decoders may requires 256M GPU memory

### Supported Graphics APIs:
- OpenGL
- OpenGL ES2/3

### Hardware Decoders
- mmal: builtin mmal decoder implementation
- MMAL: FFmpeg mmal decoder implementation
- V4L2: or "FFmpeg:hwaccel=v4l2m2m"

### Examples
In legacy driver environment, hardware decoder (MMAL, mmal) supports zero copy rendering in GLES2 and has the best performance
- legacy driver gles2: ./mdkplay -c:v MMAL test.mp4


In mesa vc4/6 driver environment(fake/full kms), hardware decoder is available, but zero copy rendering is not
- vc4/6 egl+es2: LD_PRELOAD=libX11.so.6 ./mdkplay -c:v MMAL test.mp4 # if not link against libX11(except weak) or libpulse
- vc4/6 glx: GL_ES=0 LD_PRELOAD=libGL.so.1 ./mdkplay -c:v MMAL test.mp4 # if not link against libGL or libOpenGL
- vc4/6 wayland: ./mdkplay -c:v MMAL test.mp4  # assume weston is running in x11 or CLI mode via weston-launch
- vc4/6 gbm: ./mdkplay -surface gbm -c:v MMAL test.mp4  # assume weston is running # in CLI mode

Tested on rpi1 and rpi3.

> Note: the latest sdk links against libGL.so.1, so no need to set LD_PRELOAD.

### Use in CMake Projects
```
	include(mdk-sdk-dir/lib/cmake/FindMDK.cmake)
	target_link_libraries(your_target PRIVATE mdk)
```

## Source code:
- some examples using mdk sdk: https://github.com/wang-bin/mdk-examples
- OBS Studio plugin: https://github.com/wang-bin/obs-mdk
- QtMultimedia plugin: https://github.com/wang-bin/qtmultimedia-plugins-mdk

Copyright (c) 2016-2021 WangBin(the author of QtAV) <wbsecg1 at gmail.com>
Free for opensource softwares, non-commercial softwares, QtAV donors and contributors.