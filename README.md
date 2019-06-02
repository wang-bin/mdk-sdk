[![Build Status](https://dev.azure.com/kb137035/mdk/_apis/build/status/mdk-CI-yaml?branchName=master)](https://dev.azure.com/kb137035/mdk/_build/latest?definitionId=2&branchName=master)


## Features
- Simple and powerful API set
- Cross platform: Windows, UWP, Linux, macOS, Android, iOS, Raspberry Pi
- Hardware accelerated decoding and 0-copy GPU rendering for all supported platforms
- OpenGL rendering w/ or w/o user provided context
- Ingegrated with any gui toolkits via OpenGL (Qt, SDL, glfw, SFML etc.) easily
- Seamless/Gapless media and bitrate switch for any media
- User configurable FFmpeg libraries at runtime

## MDK OpenGL v.s. MPV OpenGL CB
- No additional initialization, simply call renderVideo()


## API Levels
- ABI level APIs: the implementation, in abi namespace. depends on c++ abi. build and runtime abi must be matched.
- C APIs: No C++ ABI restriction.
- C++ APIs: a header only thin wrapper for C APIs. No C++ ABI restriction. No user code change to switch between ABI level APIs and C++ APIs.

## TODO:
- HDR support
  - [x] windows 10 HDR apis (ANGLE GLES2/3)
  - [ ] generic GLSL implementation
- Encoding, transcoding and streaming
- Subtitle
- Vulkan, D3D
- ppapi, nacl

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
