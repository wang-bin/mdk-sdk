[![Build status github](https://github.com/wang-bin/mdk-sdk/workflows/Build/badge.svg)](https://github.com/wang-bin/mdk-sdk/actions)

[![Build Status](https://dev.azure.com/kb137035/mdk/_apis/build/status/mdk-CI-yaml?branchName=master)](https://dev.azure.com/kb137035/mdk/_build/latest?definitionId=2&branchName=master)

[Nightly Build SDK](https://sourceforge.net/projects/mdk-sdk/files/nightly/)

[Changelog](https://github.com/wang-bin/mdk-sdk/blob/master/Changelog.md)

## Features
- Simple and powerful API set
- Cross platform: Windows, UWP, Linux, macOS, Android, iOS, Raspberry Pi
- Hardware accelerated decoding and 0-copy GPU rendering for all platforms
- OpenGL, D3D11, Vulkan and Metal rendering w/ or w/o user provided context
- Integrated with any gui toolkits or apps via OpenGL, D3D11, Vulkan and Metal (OBS, Qt, SDL, glfw, SFML etc.) easily
- Seamless/Gapless media and bitrate switch for any media
- HDR rendering in GPU
- Optimized Continuous seeking. As fast as mpv, but much lower cpu, memory and gpu load. Suitable for timeline preview
- Smart FFmpeg runtime. See https://github.com/wang-bin/mdk-sdk/wiki/FFmpeg-Runtime

## [API Levels](https://github.com/wang-bin/mdk-sdk/wiki/%E9%80%9A%E7%94%A8ABI%E7%9A%84CPP%E5%BA%93API%E8%AE%BE%E8%AE%A1)
- ABI level APIs(not public): the implementation, in abi namespace. depends on c++ abi. build and runtime abi must be matched.
- C APIs: No C++ ABI restriction.
- C++ APIs: a header only thin wrapper for C APIs. No C++ ABI restriction. No user code change to switch between ABI level APIs and C++ APIs.



## Install

### CMake
```
	include(mdk-sdk-dir/lib/cmake/FindMDK.cmake)
	target_link_libraries(your_target PRIVATE mdk)
```

### CocoaPods

> macOS only for now

` pod 'mdk'`

### Nuget

Install via [NuGet](https://www.nuget.org/packages/mdk) in Visual Studio for both Windows desktop and UWP



# Documents

- [wiki](https://github.com/wang-bin/mdk-sdk/wiki)
- sdk headers



## TODO:

https://github.com/wang-bin/mdk-sdk/wiki/TODO



## Open Source Modules and Examples
- swift: https://github.com/wang-bin/swiftMDK
- Android java wrapper and example: https://github.com/wang-bin/mdk-android
- MFT decoder module: https://github.com/wang-bin/mdk-mft
- sunxi decoder + renderer: https://github.com/wang-bin/mdk-sunxi
- obs plugin: https://github.com/wang-bin/obs-mdk
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
- Free for GPL softwares, opensource projects, QtAV donors and contributors, no commercial softwares: you can acquire a key from me.
- Commercial license: a key for an app for a single platform or multiple platforms.
