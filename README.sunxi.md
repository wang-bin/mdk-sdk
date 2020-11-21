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


## About SDK for SUNXI

mdk sdk for linux sunxi, with allwinner cedarv and vdpau decoder support

SDK is cross built by clang 11.0 with
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
- some examples using mdk sdk: https://github.com/wang-bin/mdk-examples
- OBS Studio plugin: https://github.com/wang-bin/obs-mdk
- QtMultimedia plugin: https://github.com/wang-bin/qtmultimedia-plugins-mdk

Copyright (c) 2016-2020 WangBin(the author of QtAV) <wbsecg1 at gmail.com>
Free for opensource softwares, non-commercial softwares, QtAV donors and contributors.