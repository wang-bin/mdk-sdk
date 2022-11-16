[![Build status github](https://github.com/wang-bin/mdk-sdk/workflows/Build/badge.svg)](https://github.com/wang-bin/mdk-sdk/actions)

[![Build Status](https://dev.azure.com/kb137035/mdk/_apis/build/status/mdk-CI-yaml?branchName=master)](https://dev.azure.com/kb137035/mdk/_build/latest?definitionId=2&branchName=master)

**Download** [Nightly Build SDK](https://sourceforge.net/projects/mdk-sdk/files/nightly/)

[Changelog](https://github.com/wang-bin/mdk-sdk/blob/master/Changelog.md). 
[API](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)

## Features

- [Simple and powerful API set](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)
- [Cross platform: Windows, UWP, Linux, macOS, Android, iOS, Raspberry Pi](https://github.com/wang-bin/mdk-sdk/wiki/System-Requirements)
- [Hardware accelerated decoders](https://github.com/wang-bin/mdk-sdk/wiki/Decoders)
- [0-copy GPU rendering for all platforms and all renderers(Vulkan is WIP.)](https://github.com/wang-bin/mdk-sdk/wiki/Zero-Copy-Renderer)
- [Dynamic OpenGL](https://github.com/wang-bin/mdk-sdk/wiki/OpenGL-Support-Matrix)
- [OpenGL, D3D11, Vulkan and Metal rendering w/ or w/o user provided context](https://github.com/wang-bin/mdk-sdk/wiki/Render-API)
- Integrated with any platform native ui apps, gui toolkits or other apps via [OpenGL, D3D11, Vulkan and Metal](https://github.com/wang-bin/mdk-sdk/wiki/Render-API) ([OBS](https://github.com/wang-bin/obs-mdk), [Flutter](https://github.com/wang-bin/fvp), [Qt](https://github.com/wang-bin/mdk-examples/tree/master/Qt), [SDL](https://github.com/wang-bin/mdk-examples/tree/master/SDL), [GLFW](https://github.com/wang-bin/mdk-examples/tree/master/GLFW), [SFML](https://github.com/wang-bin/mdk-examples/tree/master/SFML) etc.) easily
- [HDR display, HDR to SDR and SDR to HDR tone mapping](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs#player-setcolorspace-value-void-vo_opaque--nullptr)
- [Seamless/Gapless media and bitrate switch for any media](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs#player-setcolorspace-value-void-vo_opaque--nullptr)
- Optimized Continuous seeking. As fast as mpv, but much lower cpu, memory and gpu load. Suitable for [timeline preview](https://github.com/wang-bin/mdk-sdk/wiki/Typical-Usage#timeline-preview)
- [Smart FFmpeg runtime, dynamic load, compatible with 4.x/5.x abi](https://github.com/wang-bin/mdk-sdk/wiki/FFmpeg-Runtime)
- Professional codecs: GPU accelerated [HAP](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#hap) codec rendering, [Blackmagic RAW](https://github.com/wang-bin/mdk-braw)


## [API Levels](https://github.com/wang-bin/mdk-sdk/wiki/%E9%80%9A%E7%94%A8ABI%E7%9A%84CPP%E5%BA%93API%E8%AE%BE%E8%AE%A1)

- ABI level APIs(not public): the implementation, in abi namespace. depends on c++ abi. build and runtime abi must be matched. Used internally and for plugins.
- C APIs: No C++ ABI restriction.
- C++ APIs: a header only thin wrapper for C APIs. No C++ ABI restriction. No user code change to switch between ABI level APIs and C++ APIs.



## Install

### CMake

```
	include(mdk-sdk-dir/lib/cmake/FindMDK.cmake)
	target_link_libraries(your_target PRIVATE mdk)
```

### CocoaPods

> For macOS and iOS

` pod 'mdk'`

Optionally you can use [mdk.xcframework](https://sourceforge.net/projects/mdk-sdk/files/nightly/mdk-sdk-apple.tar.xz/download)

If fail to code sign: In `Build Phase`, add a `New Run Script Phase` with content `[ -n "$CODE_SIGN_IDENTITY" ] && find "$BUILT_PRODUCTS_DIR" -depth -name "libffmpeg*.dylib" -exec codesign -i mdk.framework.ffmpeg -f -vvvv -s"${EXPANDED_CODE_SIGN_IDENTITY}" ${OTHER_CODE_SIGN_FLAGS:-} --preserve-metadata=identifier,entitlements,flags {} \;`

### Nuget

Install via [NuGet](https://www.nuget.org/packages/mdk) in Visual Studio for both Windows desktop and UWP


## Documents

- [wiki](https://github.com/wang-bin/mdk-sdk/wiki)
- sdk headers



## Open Source
### Modules and Dependencies
- [License generator and validator](https://github.com/wang-bin/appkey)
- [Android java wrapper and example](https://github.com/wang-bin/mdk-android)
- [blackmagic raw plugin](https://github.com/wang-bin/mdk-braw)
- [MediaFoundation decoder module](https://github.com/wang-bin/mdk-mft)
- [av1 software decoder module](https://github.com/wang-bin/mdk-dav1d)
- [sunxi decoder + renderer](https://github.com/wang-bin/mdk-sunxi)
- [GFX surface and render loop](https://github.com/wang-bin/ugs)
- [Java support](https://github.com/wang-bin/JMI)
- [Android java and jni APIs in C++](https://github.com/wang-bin/AND)
- [C++ TLS](https://github.com/wang-bin/ThreadLocal)
- [C++ compatibility layer](https://github.com/wang-bin/cppcompat)
- [cmake tools](https://github.com/wang-bin/cmake-tools)

### Examples and Plugins for Other Frameworks
- [examples for different platforms and gui toolkits](https://github.com/wang-bin/mdk-examples)
- [Swift player for macOS](https://github.com/wang-bin/SPV)
- [obs-studio video source plugin](https://github.com/wang-bin/obs-mdk)
- [as a qtmultimedia plugin](https://github.com/wang-bin/qtmultimedia-plugins-mdk)

### Language Bindings
- [swift binding](https://github.com/wang-bin/mdkSwift)

## Users

<a href="https://bigringvr.com"><img src="https://bigringvr.com/images/BR_Logo_only.svg" width=140 height=120 alt="BigRingVR"/></a>
<a herf="http://1218.io"><img src="https://avatars.githubusercontent.com/u/15963166?v=4" width=120 height=120 alt="Seer"/></a>
<a href="https://www.heavym.net/en"><img alt="HeavyM" src="https://eadn-wc04-3624428.nxedge.io/cdn/wp-content/uploads/2020/09/Logo-Verticale-Base-Sans-signature-Small-border.svg" height=120 ></a>
<a href="https://sureyyasoft.com"><img class="logo" src="http://sureyyasoft.com/images/s_images/logo_title.png"  height=70 alt="SureyyaSoft"></a>
[![Flyability](https://www.flyability.com/hs-fs/hubfs/Brand_Identity/Flyability%20Logo%20Package/2%20-%20Horizontal/flyability_logo_horizontal_color_trimmed-1.png)](https://www.flyability.com)
[![Quipu](http://www.quipu.eu/wp-content/uploads/2015/03/logo-quipu-innovative-solutions-in-medical-ultrasound.png)](www.quipu.eu)
[![GyroFlow](https://gyroflow.xyz/assets/logo.png)](https://gyroflow.xyz)
<a href="https://www.xnview.com/en/xnviewmp"><img class="logo" src="https://www.xnview.com/img/app-xnviewmp-512.webp"  height=120 alt="XnViewMP"></a>

[金嵘达科技](http://www.kingroda.com)

[爱玩宝](https://www.aiwanbao.com)




## License

- Use for free: make sure your sdk is updated, otherwise you may see an QR image in the last frame. sdk will be released every month.
- Free for opensource projects, QtAV donors and contributors, non-commercial softwares: you can acquire a key from me.
- Commercial license: a key for an app for a single platform or multiple platforms.

License key generator and validator is [open source](https://github.com/wang-bin/appkey)