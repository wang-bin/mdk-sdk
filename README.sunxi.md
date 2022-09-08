## MDK: Multimedia Development Kit
### [Changelog](https://github.com/wang-bin/mdk-sdk/blob/master/Changelog.md)
### [API](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)

### Features
- [Simple and powerful API set](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)
- [Cross platform: Windows, UWP, Linux, macOS, Android, iOS, Raspberry Pi](https://github.com/wang-bin/mdk-sdk/wiki/System-Requirements)
- [Hardware accelerated decoders](https://github.com/wang-bin/mdk-sdk/wiki/Decoders)
- [0-copy GPU rendering for all platforms and all renderers(Vulkan is WIP.)](https://github.com/wang-bin/mdk-sdk/wiki/Zero-Copy-Renderer)
- [Dynamic OpenGL](https://github.com/wang-bin/mdk-sdk/wiki/OpenGL-Support-Matrix)
- [OpenGL, D3D11, Vulkan and Metal rendering w/ or w/o user provided context](https://github.com/wang-bin/mdk-sdk/wiki/Render-API)
- Integrated with any platform native ui apps, gui toolkits or other apps via [OpenGL, D3D11, Vulkan and Metal](https://github.com/wang-bin/mdk-sdk/wiki/Render-API) ([OBS](https://github.com/wang-bin/obs-mdk), [Qt](https://github.com/wang-bin/mdk-examples/tree/master/Qt), [SDL](https://github.com/wang-bin/mdk-examples/tree/master/SDL), [GLFW](https://github.com/wang-bin/mdk-examples/tree/master/GLFW), [SFML](https://github.com/wang-bin/mdk-examples/tree/master/SFML) etc.) easily
- [Seamless/Gapless media and bitrate switch for any media](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)
- HDR rendering in GPU
- Optimized Continuous seeking. As fast as mpv, but much lower cpu, memory and gpu load. Suitable for timeline preview
- [Smart FFmpeg runtime, dynamic load, compatible with 4.x/5.x abi](https://github.com/wang-bin/mdk-sdk/wiki/FFmpeg-Runtime)

## About SDK for SUNXI

mdk sdk for linux sunxi, with allwinner cedarv and vdpau decoder support

SDK is cross built by clang 15.0 with
- cmake toolchain file https://github.com/wang-bin/cmake-tools/blob/master/sunxi.clang.cmake
- sysroot: https://sourceforge.net/projects/avbuild/files/sunxi/sunxi-sysroot.tar.xz/download
- ffmpeg: https://sourceforge.net/projects/avbuild/files/sunxi/ffmpeg-master-sunxi-clang-lite.tar.xz/download
- libc++ 10.0

SDK can be used by any C or C++11 compiler, e.g. g++, clang

### Runtime Requirements
- https://linux-sunxi.org/CedarX
- https://linux-sunxi.org/Cedrus/libvdpau-sunxi

tested device info
- pcdiuno, allwinner a10, sun4i, Linaro 12.11, Linux ubuntu 3.4.29+ #1 PREEMPT Tue Nov 26 15:20:06 CST 2013 armv7l armv7l armv7l GNU/Linux

### Examples
- [Best performance] cedarv decoder via libvecore, texture uploading is accelerated by UMP:

`./bin/mdkplay -c:v CedarX video_file`

1080p@24fps 7637kb/s h264 decoding + rendering ~28% cpu

- cedarv decoder via libvecore, no UMP accelerated: `GLVA_HOST=1 ./bin/mdkplay -c:v CedarX video_file`

1080p@24fps 7637kb/s h264 decoding + rendering ~96% cpu

- vdpau decoder copy mode: `GLVA_HOST=1 ./bin/mdkplay -c:v VDPAU video_file`

1080p@24fps 7637kb/s h264 decoding + rendering ~97% cpu

- vdpau decoder zero copy mode via nv interop extension(not tested, I have no working vdpau driver): `./bin/mdkplay -c:v VDPAU video_file`

- test decoder speed:

```
    ./bin/framereader -c:v CedarX video_file  # 1080p h264 ~84fps
    ./bin/framereader -c:v FFmpeg video_file  # 1080p h264 ~12fps
```

if default audio device does not sound correctly, try to change the device name via environment var `ALSA_DEVICE`, e.g.

`export ALSA_DEVICE="hw:0,0"`

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

Copyright (c) 2016-2022 WangBin(the author of QtAV) <wbsecg1 at gmail.com>
Free for opensource softwares, non-commercial softwares, QtAV donors and contributors.