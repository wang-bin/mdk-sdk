## MDK: Multimedia Development Kit

**Use generic linux sdk package for raspberry pi3/4 with modern RaspberryPi OS**

### [Changelog](https://github.com/wang-bin/mdk-sdk/blob/master/Changelog.md)
### [API](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)

### Features
- [Simple and powerful API set](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)
- [Cross platform: Windows, UWP, Linux, macOS, Android, iOS, Raspberry Pi](https://github.com/wang-bin/mdk-sdk/wiki/System-Requirements)
- [Hardware accelerated decoders](https://github.com/wang-bin/mdk-sdk/wiki/Decoders)
- [0-copy GPU rendering for all platforms and all renderers(Vulkan is WIP.)](https://github.com/wang-bin/mdk-sdk/wiki/Zero-Copy-Renderer)
- [Dynamic OpenGL](https://github.com/wang-bin/mdk-sdk/wiki/OpenGL-Support-Matrix)
- [OpenGL, D3D11, Vulkan and Metal rendering w/ or w/o user provided context](https://github.com/wang-bin/mdk-sdk/wiki/Render-API)
- Integrated with any platform native ui apps, gui toolkits or other apps via [OpenGL, D3D11, Vulkan and Metal](https://github.com/wang-bin/mdk-sdk/wiki/Render-API) ([OBS](https://github.com/wang-bin/obs-mdk), [Flutter](https://pub.dev/packages/fvp), [Qt](https://github.com/wang-bin/mdk-examples/tree/master/Qt), [SDL](https://github.com/wang-bin/mdk-examples/tree/master/SDL), [GLFW](https://github.com/wang-bin/mdk-examples/tree/master/GLFW), [SFML](https://github.com/wang-bin/mdk-examples/tree/master/SFML) etc.) easily
- [HDR display, HDR to SDR and SDR to HDR tone mapping](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs#player-setcolorspace-value-void-vo_opaque--nullptr)
- [Seamless/Gapless media and bitrate switch for any media](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs#player-setcolorspace-value-void-vo_opaque--nullptr)
- Optimized Continuous seeking. As fast as mpv, but much lower cpu, memory and gpu load. Suitable for [timeline preview](https://github.com/wang-bin/mdk-sdk/wiki/Typical-Usage#timeline-preview)
- [Smart FFmpeg runtime, dynamic load, compatible with 4.x~6.x abi](https://github.com/wang-bin/mdk-sdk/wiki/FFmpeg-Runtime)
- Professional codecs: GPU accelerated [HAP](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#hap) codec rendering, [Blackmagic RAW](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#braw), [R3D](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#r3d)

## About SDK for Legacy Raspberry Pi
SDK is cross built by clang 16.0 with
- cmake toolchain file https://github.com/wang-bin/cmake-tools/blob/master/raspberry-pi.clang.cmake
- sysroot: https://sourceforge.net/projects/avbuild/files/raspberry-pi/raspberry-pi-sysroot.tar.xz/download
- ffmpeg: https://sourceforge.net/projects/avbuild/files/raspberry-pi/ffmpeg-master-raspberry-pi-clang-lite.tar.xz/download
- libc++ 16.0

SDK can be used by any C or C++11 compiler, e.g. g++, clang

pi 4: ALSA_DEVICE=sysdefault

clang >= 9 result dso can not be loaded on rpi1, maybe there is a bug in lld

### [Runtime Requirements](https://github.com/wang-bin/mdk-sdk/wiki/System-Requirements#linux-desktop-raspberry-pi-64bit)
- gapless playback hardware decoders may requires 256M GPU memory

### [Supported Graphics APIs:](https://github.com/wang-bin/mdk-sdk/wiki/Render-API)
- OpenGL
- OpenGL ES2/3

### [Supported Decoders:](https://github.com/wang-bin/mdk-sdk/wiki/Decoders)
- mmal: builtin mmal decoder implementation
- MMAL: FFmpeg mmal decoder implementation
- V4L2: or "FFmpeg:hwaccel=v4l2m2m"

### Examples
In legacy driver environment, hardware decoder (MMAL, mmal) supports zero copy rendering in GLES2 and has the best performance
- legacy driver gles2: ./window -c:v MMAL test.mp4


In mesa vc4/6 driver environment(fake/full kms), hardware decoder is available, but zero copy rendering is not
- vc4/6 egl+es2: LD_PRELOAD=libX11.so.6 ./window -c:v MMAL test.mp4 # if not link against libX11(except weak) or libpulse
- vc4/6 glx: GL_ES=0 LD_PRELOAD=libGL.so.1 ./window -c:v MMAL test.mp4 # if not link against libGL or libOpenGL
- vc4/6 wayland: ./window -c:v MMAL test.mp4  # assume weston is running in x11 or CLI mode via weston-launch
- vc4/6 gbm: ./window -surface gbm -c:v MMAL test.mp4  # assume weston is running # in CLI mode

Tested on rpi1 and rpi3.

> Note: the latest sdk links against libGL.so.1, so no need to set LD_PRELOAD.

### Use in CMake Projects
```
	include(mdk-sdk-dir/lib/cmake/FindMDK.cmake)
	target_link_libraries(your_target PRIVATE mdk)
```

## Source code:
- [some examples using mdk sdk](https://github.com/wang-bin/mdk-examples)
- [OBS Studio plugin](https://github.com/wang-bin/obs-mdk)
- [QtMultimedia plugin](https://github.com/wang-bin/qtmultimedia-plugins-mdk)
- [MFT decoder module](https://github.com/wang-bin/mdk-mft)
- [dav1d decoder module](https://github.com/wang-bin/mdk-dav1d)

Copyright (c) 2016-2023 WangBin(the author of QtAV) <wbsecg1 at gmail.com>
Free for opensource softwares, non-commercial softwares, QtAV donors and contributors.