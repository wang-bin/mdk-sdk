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
FFmpeg modules can be specified via environment var AVUTIL_LIB, AVCODEC_LIB, AVFORMAT_LIB, AVFILTER_LIB, SWRESAMPLE_LIB, SWSCALE_LIB, or SetGlobalOption() with key avutil_lib, avcodec_lib, avformat_lib, swresample_lib, swscale_lib, avfilter_lib. For example `SetGlobalOption("avutil_lib", "libavutil-56.so")`

If ffmpeg any module is not set, it's searched in the following order
- current module dir > framework dir(apple) > system default search dir
- single ffmpeg library > ffmpeg modules w/ version > ffmpeg modules w/o version


## About SDK for Android
SDK is built with
- ffmpeg: https://sourceforge.net/projects/avbuild/files/android/ffmpeg-master-android-clang-lite.tar.xz/download
- ndk r22, libc++_shared

SDK can be used by any C or C++11 compiler, e.g. g++, clang

### Supported Graphics APIs:
- OpenGL ES2/3
- Vulkan

### OpenGL Context
- Create by mdk: use SurfaceView's Surface to initialize rendering thread
- Created by user: use GLSurfaceView, TextureView or whatever

### Decoders:
- FFmpeg
- MediaCodec: FFmpeg mediacodec implementation
- AMediaCodec: builtin mediacodec implementation, using libmediandk or java api. propertyes: "surface" = "0" or "1", "copy" = "0" or "1" when "surface" is "0", "java" = "0" or "1"(use java or mediandk), "async" = "0" or "1"(android 9.0 is required by async mode)

MediaCodec/AMediaCodec decoder will not be destroyed if app go to background, and continues to work when resumed.

### Audio Renderers
- OpenSLES
- AudioTrack (default)

### Data Source
- "content:"
- "android.resource:"

### Use in CMake Projects
```
	include(mdk-sdk-dir/lib/cmake/FindMDK.cmake)
	target_link_libraries(your_target PRIVATE mdk)
```

## Source code:
- Android java wrapper and example: https://github.com/wang-bin/mdk-android
- some examples using mdk sdk: https://github.com/wang-bin/mdk-examples
- OBS Studio plugin: https://github.com/wang-bin/obs-mdk
- QtMultimedia plugin: https://github.com/wang-bin/qtmultimedia-plugins-mdk
- libmediandk and other java classes implemented in C++: https://github.com/wang-bin/AND
- JNI Modern Interface: https://github.com/wang-bin/JMI

Copyright (c) 2016-2020 WangBin(the author of QtAV) <wbsecg1 at gmail.com>
Free for opensource softwares, non-commercial softwares, QtAV donors and contributors.