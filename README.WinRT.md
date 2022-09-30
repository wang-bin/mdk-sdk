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
- Integrated with any platform native ui apps, gui toolkits or other apps via [OpenGL, D3D11, Vulkan and Metal](https://github.com/wang-bin/mdk-sdk/wiki/Render-API) ([OBS](https://github.com/wang-bin/obs-mdk), [Flutter](https://github.com/wang-bin/fvp), [Qt](https://github.com/wang-bin/mdk-examples/tree/master/Qt), [SDL](https://github.com/wang-bin/mdk-examples/tree/master/SDL), [GLFW](https://github.com/wang-bin/mdk-examples/tree/master/GLFW), [SFML](https://github.com/wang-bin/mdk-examples/tree/master/SFML) etc.) easily
- [Seamless/Gapless media and bitrate switch for any media](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)
- HDR rendering in GPU
- Optimized Continuous seeking. As fast as mpv, but much lower cpu, memory and gpu load. Suitable for timeline preview
- [Smart FFmpeg runtime, dynamic load, compatible with 4.x/5.x abi](https://github.com/wang-bin/mdk-sdk/wiki/FFmpeg-Runtime)


## About SDK for Windows Store
SDK is built by
- clang-cl 15.0, with Windows SDK 10.0.19041.0, MSVC CRT 14.28.29333, [FFmpeg](https://sourceforge.net/projects/avbuild/files/uwp/ffmpeg-master-uwp-vs2022-lite.tar.xz/download)
- latest VS2022 with [FFmpeg](https://sourceforge.net/projects/avbuild/files/uwp/ffmpeg-master-uwp-vs2022-lite.tar.xz/download)

### Use in Visual Studio
#### Install via NuGet (Recommended)
mdk is published on https://www.nuget.org/packages/mdk/. Now you can install it in visual studio.

#### Import from Release Package
mdk sdk can be imported by vs projects. Insert the following line in your vcxproj as the last element of `Project` (assume mdk-sdk is in the same dir as vcxproj)

    <Import Project="mdk-sdk\build\native\MDK.targets" Condition="Exists('mdk-sdk\build\native\MDK.targets')" />


Once installed or imported, necessary compile flags and link flags will be added, runtime dlls will be copied to output dir.

### Use in CMake Projects
```
	include(mdk-sdk-dir/lib/cmake/FindMDK.cmake)
	target_link_libraries(your_target PRIVATE mdk)
```


### [Runtime Requirements](https://github.com/wang-bin/mdk-sdk/wiki/System-Requirements#uwp)
Optional:
- libEGL.dll, libGLESv2.dll, D3DCompiler_47/43.dll. Qt apps can use qt's dlls

### [Supported Graphics APIs:](https://github.com/wang-bin/mdk-sdk/wiki/Render-API)
- D3D11: recommended
- [OpenGL ES2/3](https://github.com/wang-bin/mdk-sdk/wiki/OpenGL-Support-Matrix): via ANGLE or others. The default if EGL runtime is found.
- Vulkan(No UWP)

### [Supported Decoders:](https://github.com/wang-bin/mdk-sdk/wiki/Decoders)
- [FFmpeg](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#ffmpeg). options: threads=N. e.g. -c:v FFmpeg. -c:v FFmpeg:threads=4
- [MFT](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#mft). options: d3d=0/9/11, pool=0/1. e.g. -c:v MFT(software), -c:v MFT:d3d=11(hardware).
- [D3D11](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#d3d11): via FFmpeg

## Source code:
- [some examples using mdk sdk](https://github.com/wang-bin/mdk-examples)
- [OBS Studio plugin](https://github.com/wang-bin/obs-mdk)
- [QtMultimedia plugin](https://github.com/wang-bin/qtmultimedia-plugins-mdk)
- [MFT decoder module](https://github.com/wang-bin/mdk-mft)
- [dav1d decoder module](https://github.com/wang-bin/mdk-dav1d)

Copyright (c) 2016-2022 WangBin(the author of QtAV) <wbsecg1 at gmail.com>
Free for opensource softwares, non-commercial softwares, QtAV donors and contributors.