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
FFmpeg modules can be specified via environment var AVUTIL_LIB, AVCODEC_LIB, AVFORMAT_LIB, AVFILTER_LIB, SWRESAMPLE_LIB, SWSCALE_LIB, or SetGlobalOption() with key avutil_lib, avcodec_lib, avformat_lib, swresample_lib, swscale_lib, avfilter_lib. For example `SetGlobalOption("avutil_lib", "ffmpeg-4.dll")`

If ffmpeg any module is not set, it's searched in the following order
- current module dir > framework dir(apple) > system default search dir
- single ffmpeg library > ffmpeg modules w/ version > ffmpeg modules w/o version


## About SDK for Windows Store
SDK is built by clang-cl 11.0 + lld with
- FFmpeg: https://sourceforge.net/projects/avbuild/files/windows-store/ffmpeg-master-windows-store-clang-static-lite.tar.xz/download
- Windows SDK 10.0.19041.0
- MSVC CRT 14.26.28801

### Use in Visual Studio
#### Install via NuGet (Recommended)
mdk is published on https://www.nuget.org/packages/mdk/. Now you can install it in visual studio.

#### Import from Release Package
mdk sdk can be imported by vs projects. Insert the following line in your vcxproj as the last element of `Project` (assume mdk-sdk is in the same dir as vcxproj)

    <Import Project="mdk-sdk\build\native\MDK.targets" Condition="Exists('mdk-sdk\build\native\MDK.targets')" />


Once installed or imported, necessary compile flags and link flags will be added, runtime dlls will be copied to output dir.


### Runtime Requirements
Optional:
- libEGL.dll, libGLESv2.dll, D3DCompiler_47/43.dll. Qt apps can use qt's dlls

### Supported Graphics APIs:
- D3D11: recommended
- OpenGL ES2/3: via ANGLE or others. The default if EGL runtime is found.

### Supported Decoders:
- FFmpeg. options: threads=N. e.g. -c:v FFmpeg. -c:v FFmpeg:threads=4
- MFT. options: d3d=0/9/11, pool=0/1. e.g. -c:v MFT(software), -c:v MFT:d3d=11(hardware).
- D3D11: via FFmpeg

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