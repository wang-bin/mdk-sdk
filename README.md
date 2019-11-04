[![Build Status](https://dev.azure.com/kb137035/mdk/_apis/build/status/mdk-CI-yaml?branchName=master)](https://dev.azure.com/kb137035/mdk/_build/latest?definitionId=2&branchName=master)

[Nightly Build SDK](https://sourceforge.net/projects/mdk-sdk/files/nightly/)

Install via [NuGet](https://www.nuget.org/packages/mdk) in Visual Studio

## Features
- Simple and powerful API set
- Cross platform: Windows, UWP, Linux, macOS, Android, iOS, Raspberry Pi
- Hardware accelerated decoding and 0-copy GPU rendering for all platforms
- OpenGL rendering w/ or w/o user provided context
- Ingegrated with any gui toolkits via OpenGL (Qt, SDL, glfw, SFML etc.) easily
- Seamless/Gapless media and bitrate switch for any media
- User configurable FFmpeg libraries at runtime
- HDR rendering in GPU

## FFmpeg Runtime Lookup
FFmpeg modules can be specified via environment var AVUTIL_LIB, AVCODEC_LIB, AVFORMAT_LIB, AVFILTER_LIB, SWRESAMPLE_LIB, SWSCALE_LIB, or SetGlobalOption() with key avutil_lib, avcodec_lib, avformat_lib, swresample_lib, swscale_lib, avfilter_lib. For example `SetGlobalOption("avutil_lib", "/opt/lib/libavutil.so.56")`

If ffmpeg any module is not set, it's searched in the following order
- current module dir > framework dir(apple) > system default search dir
- single ffmpeg library w/ version > single ffmpeg library w/o version > ffmpeg modules w/ version > ffmpeg modules w/o version

## MDK OpenGL v.s. MPV OpenGL CB
- No additional initialization, simply call renderVideo()


## [API Levels](https://github.com/wang-bin/mdk-sdk/wiki/%E9%80%9A%E7%94%A8ABI%E7%9A%84CPP%E5%BA%93API%E8%AE%BE%E8%AE%A1)
- ABI level APIs: the implementation, in abi namespace. depends on c++ abi. build and runtime abi must be matched.
- C APIs: No C++ ABI restriction.
- C++ APIs: a header only thin wrapper for C APIs. No C++ ABI restriction. No user code change to switch between ABI level APIs and C++ APIs.

## TODO:
https://github.com/wang-bin/mdk-sdk/wiki/TODO

## Open Source Modules and Examples
- MFT decoder module: https://github.com/wang-bin/mdk-mft
- examples for different platforms and gui toolkits: https://github.com/wang-bin/mdk-examples
- as a qtmultimedia plugin: https://github.com/wang-bin/qtmultimedia-plugins-mdk
- GFX surface: https://github.com/wang-bin/ugs
- Java support: https://github.com/wang-bin/JMI
- Android APIs in C++: https://github.com/wang-bin/AND
- C++ TLS: https://github.com/wang-bin/ThreadLocal
- C++ compatibility layer: https://github.com/wang-bin/cppcompat
- cmake: https://github.com/wang-bin/cmake-tools

## License
- Use for free: make sure your sdk is updated, otherwise you may see an QR image in the last frame. sdk will be released every month.
- Free for GPL softwares: you can acquire a key from me.
- Commercial license: a key for an app for a single platform or multiple platforms.
