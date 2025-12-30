[![Build status github](https://github.com/wang-bin/mdk-sdk/workflows/Build/badge.svg)](https://github.com/wang-bin/mdk-sdk/actions)

[![Build Status](https://dev.azure.com/kb137035/mdk/_apis/build/status/mdk-CI-yaml?branchName=master)](https://dev.azure.com/kb137035/mdk/_build/latest?definitionId=2&branchName=master)

**Download** latest [Nightly Build SDK from sourceforge](https://sourceforge.net/projects/mdk-sdk/files/nightly/) or [github actions](https://nightly.link/wang-bin/mdk-sdk/workflows/build/master)


Sourceforge[![Sourceforge](https://img.shields.io/sourceforge/dt/mdk-sdk)](https://sourceforge.net/projects/mdk-sdk/files)
Github Releases[![Github Release](https://img.shields.io/github/downloads/wang-bin/mdk-sdk/total)](https://github.com/wang-bin/mdk-sdk/releases)
NuGet[![NuGet](https://img.shields.io/nuget/dt/mdk)](https://www.nuget.org/packages/mdk)


[Changelog](https://github.com/wang-bin/mdk-sdk/blob/master/Changelog.md).
[API](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)

## Features

- [Simple and powerful API set](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs)
- [Cross platform: Windows(x86, arm), UWP, Linux, macOS, Android, iOS, tvOS, visionOS, Raspberry Pi, RockChip](https://github.com/wang-bin/mdk-sdk/wiki/System-Requirements)
- [Hardware accelerated decoders for all platforms](https://github.com/wang-bin/mdk-sdk/wiki/Decoders)
- [0-copy GPU rendering for all platforms and all renderers(Vulkan is WIP.)](https://github.com/wang-bin/mdk-sdk/wiki/Zero-Copy-Renderer)
- [Dynamic OpenGL](https://github.com/wang-bin/mdk-sdk/wiki/OpenGL-Support-Matrix)
- [OpenGL, D3D11, D3D12, Vulkan and Metal rendering w/ or w/o user provided context](https://github.com/wang-bin/mdk-sdk/wiki/Render-API)
- Integrated with any platform native ui apps, gui toolkits or other apps via [OpenGL, D3D11/12, Vulkan and Metal](https://github.com/wang-bin/mdk-sdk/wiki/Render-API) ([WinUI3](https://github.com/Damix48/WinUI3MDK/tree/main), [OBS](https://github.com/wang-bin/obs-mdk), [Flutter](https://pub.dev/packages/fvp), [Qt](https://github.com/wang-bin/mdk-examples/tree/master/Qt), [SDL](https://github.com/wang-bin/mdk-examples/tree/master/SDL), [GLFW](https://github.com/wang-bin/mdk-examples/tree/master/GLFW), [SFML](https://github.com/wang-bin/mdk-examples/tree/master/SFML), [.NET Avalonia](https://github.com/wang-bin/mdk-examples/tree/master/Avalonia) etc.) easily
- [HDR display metadata passthrough, HDR <=> SDR tone mapping](https://github.com/wang-bin/mdk-sdk/wiki/HDR). You can use HDR display in [Qt6(6.6+ for macOS, 6.x for windows)](https://github.com/wang-bin/mdk-examples/tree/master/Qt/qmlrhi), [OBS Studio](https://github.com/wang-bin/obs-mdk), Android SurfaceView and more.
- Dolby Vision rendering, including Profile 5. Support HEVC and AV1.
- HEVC, VP8/9 transparent videos(alpha channel) support for all decoders and renderers
- Professional codecs: GPU accelerated [HAP](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#hap) codec rendering, [Blackmagic RAW](https://github.com/wang-bin/mdk-braw), [R3D, N-RAW](https://github.com/wang-bin/mdk-r3d), [nvJPEG2000](https://github.com/wang-bin/mdk-nvjp2k)
- Subtitle rendering, including ass, plain text, bitmap, closed caption
- [Seamless/Gapless media and bitrate switch for any media](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs#player-setcolorspace-value-void-vo_opaque--nullptr)
- Optimized Continuous seeking. As fast as mpv, but much lower cpu, memory and gpu load. Suitable for [timeline preview](https://github.com/wang-bin/mdk-sdk/wiki/Typical-Usage#timeline-preview)
- [Smart FFmpeg runtime, dynamic load, binary compatible with 4.0~8.x](https://github.com/wang-bin/mdk-sdk/wiki/FFmpeg-Runtime)


## Install

### CMake

```cmake
  include(${MDK_SDK_DIR}/lib/cmake/FindMDK.cmake)
  target_link_libraries(your_target PRIVATE mdk)
```

### Qt qmake
```qmake
include($$MDK_SDK_DIR/mdk.pri)
```

### CocoaPods

#### (Objective-)C/C++ Users
```ruby
pod 'mdk'
```

Optionally you can use [mdk.xcframework](https://sourceforge.net/projects/mdk-sdk/files/nightly/mdk-sdk-apple.tar.xz/download) directly.

#### Swift Users
Add `swift-mdk` via swift package manager, or
```ruby
pod 'swift-mdk'
```
and
```swift
import swift_mdk
```

### Nuget

Install via [NuGet](https://www.nuget.org/packages/mdk) in Visual Studio for both Windows desktop and UWP

## macOS Hardened Runtime
You may fail to run(or codesign) with default hardened runtime options because there are some dylib files in mdk.framework not signed correctly. You can either select `Disable Library Validation` in `Hardened Runtime` options, or sign dylib(**RECOMMENDED**): In `Build Phase`, add a `New Run Script Phase` with content
```bash
[ -n "$CODE_SIGN_IDENTITY" ] && find "$BUILT_PRODUCTS_DIR" -depth -path "*mdk.framework/*" -name "lib*.dylib" -exec codesign -f -vvvv -s"${EXPANDED_CODE_SIGN_IDENTITY}" ${OTHER_CODE_SIGN_FLAGS:-} --preserve-metadata=identifier,entitlements,flags {} \;
```

## Distribute
- mdk(libmdk.so.0/ibmdk.dylib/mdk.dll) and ffmpeg library(or standard ffmpeg libraries) are always REQUIRED
- libass.dll/libass.dylib/ass.framework/libass.so can be optional if not using subtitle rendering
- mdk-braw.dll/libmdk-braw.{so,dylib}: optional, for blackmagic raw videos
- mdk-r3d.dll/libmdk-r3d.{so,dylib}: optional, for RED raw and N-RAW videos
- mdk.pdb/libmdk.so*.dsym: debug symbols.
- Add [libdav1d.dll/libdav1d.dylib/dav1d.framework/libdav1d.so](https://sourceforge.net/projects/mdk-sdk/files/deps/dep.7z/download) to support av1 software decoding

## Documents

- [wiki](https://github.com/wang-bin/mdk-sdk/wiki)
- sdk headers


### Recommended settings
Since 0.35.0, `player.setProperty("video.decoders", GetGlobalOption("video.decoders.hint"))` will prefer hardware decoders over software ones, and the following `player.setDecoders()` is not required.
- macOS, iOS: `player.setDecoders(MediaType::Video, {"VT", "hap", "FFmpeg", "dav1d"});`
- Windows: `player.setDecoders(MediaType::Video, {"MFT:d3d=11", "D3D11", "DXVA", "CUDA", "hap", "FFmpeg", "dav1d"});`
- Linux:
```cpp
    // XInitThreads(); // If using x11. before any x11 api call. some gui toolkits already call this, e.g. qt, glfw
    SetGlobalOption("X11Display", DisplayPtr); // If using x11. Requred by VAAPI, VDPAU
    player.setDecoders(MediaType::Video, {"VAAPI", "VDPAU", "CUDA", "hap", "FFmpeg", "dav1d"});
```
- Raspberry Pi: use [mdk-sdk-linux.tar.xz](https://sourceforge.net/projects/mdk-sdk/files/nightly/mdk-sdk-linux.tar.xz/download), delete `libffmpeg.so.*` to use system ffmpeg to support hardware decoder and use EGL for 0-copy rendering
```cpp
    player.setDecoders(MediaType::Video, {"V4L2M2M", "FFmpeg:hwcontext=drm", "FFmpeg", "dav1d"});
```

- RockChip: [mdk-sdk-linux.tar.xz](https://sourceforge.net/projects/mdk-sdk/files/nightly/mdk-sdk-linux.tar.xz/download) contains a [rockchip decoder plugin](https://github.com/wang-bin/mdk-rockchip). You can also use ffmpeg's `rkmpp` decoder: delete `libffmpeg.so.*` and use upstream ffmpeg or [ffmpeg-rockchip](https://github.com/nyanmisaka/ffmpeg-rockchip) with rkmpp enabled. OpenGL ES2/3 0-copy rendering is supported

```cpp
    SetGlobalOption("gl.ubo", "0"); // optional. required by some buggy drivers
    player.setDecoders(MediaType::Video, {"rockchip", "rkmpp", "FFmpeg", "dav1d"});
```

- Android:
```cpp
    SetGlobalOption("JavaVM", JvmPtr); // REQUIRED
    player.setDecoders(MediaType::Video, {"AMediaCodec", "FFmpeg", "dav1d"});
```

## Open Source
### Modules and Dependencies
- [License generator and validator](https://github.com/wang-bin/appkey)
- [Android java wrapper and example](https://github.com/wang-bin/mdk-android)
- [MediaFoundation decoder module](https://github.com/wang-bin/mdk-mft)
- [av1 software decoder module](https://github.com/wang-bin/mdk-dav1d)
- [sunxi decoder + renderer](https://github.com/wang-bin/mdk-sunxi)
- [GFX surface and render loop](https://github.com/wang-bin/ugs)
- [JNI C++ api](https://github.com/wang-bin/JMI)
- [Android java and jni APIs in C++](https://github.com/wang-bin/AND)
- [C++ TLS](https://github.com/wang-bin/ThreadLocal)
- [C++ compatibility layer](https://github.com/wang-bin/cppcompat)
- [cmake tools](https://github.com/wang-bin/cmake-tools)
- [Blackmagic RAW](https://github.com/wang-bin/mdk-braw)
- [R3D RAW, N-RAW](https://github.com/wang-bin/mdk-r3d)
- [nvJPEG2000](https://github.com/wang-bin/mdk-nvjp2k)
- [rockchip](https://github.com/wang-bin/mdk-rockchip)

### Examples and Plugins for Other Frameworks
- [examples for different platforms and gui toolkits](https://github.com/wang-bin/mdk-examples)
- [Swift player and QuickLook plugin for macOS](https://github.com/wang-bin/SPV)
- [obs-studio video source plugin](https://github.com/wang-bin/obs-mdk)
- [as a qtmultimedia plugin](https://github.com/wang-bin/qtmultimedia-plugins-mdk)

### Language Bindings
- [Swift binding](https://github.com/wang-bin/swift-mdk)
- [Flutter/Dart](https://pub.dev/packages/fvp)
- [C#](https://github.com/axojhf/MDK.SDK.NET)

## Sponsors
[![Sportimization](https://www.sportimization.com/assets/images/logo_sportimization_small.png)](https://www.sportimization.com)

## Users

<a href="https://bigringvr.com"><img src="https://bigringvr.com/images/BR_Logo_only.svg" width=140 height=120 alt="BigRingVR"/></a>
<a href="http://1218.io"><img src="https://avatars.githubusercontent.com/u/15963166?v=4" width=120 height=120 alt="Seer"/></a>
<a href="https://www.heavym.net/en"><img alt="HeavyM" src="https://eadn-wc04-3624428.nxedge.io/cdn/wp-content/uploads/2020/09/Logo-Verticale-Base-Sans-signature-Small-border.svg" height=120 ></a>
[![Sportimization](https://www.sportimization.com/assets/images/logo_sportimization_small.png)](https://www.sportimization.com)
<a href="https://sureyyasoft.com"><img class="logo" src="http://sureyyasoft.com/images/s_images/logo_title.png"  height=70 alt="SureyyaSoft"></a>
[![Flyability](https://www.flyability.com/hs-fs/hubfs/Brand_Identity/Flyability%20Logo%20Package/2%20-%20Horizontal/flyability_logo_horizontal_color_trimmed-1.png)](https://www.flyability.com)
[![Quipu](http://www.quipu.eu/wp-content/uploads/2015/03/logo-quipu-innovative-solutions-in-medical-ultrasound.png)](www.quipu.eu)
[![GyroFlow](https://gyroflow.xyz/assets/logo.png)](https://gyroflow.xyz)
<a href="https://www.xnview.com/en/xnviewmp"><img class="logo" src="https://www.xnview.com/img/app-xnviewmp-512.png"  height=120 alt="XnViewMP"></a>
[![www.connecting-technology](https://static.wixstatic.com/media/85712a_fe1dd2a84e17437e913dcfcdc89f40a4.jpg/v1/fill/w_460,h_240,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/85712a_fe1dd2a84e17437e913dcfcdc89f40a4.jpg)](https://www.connecting-technology.com)
<a href="https://apps.apple.com/us/app/kalismart/id1530155654"><img src="http://www.kalimind.com/assets/images/kalimind_logo.svg" alt="kalismart" height=120></a>
[NOTIONTHEORY](https://www.notiontheory.com/)
<a href="https://smartplayer.ru"><img src="https://static.tildacdn.com/tild3437-3132-4139-b365-373030343131/Group_100.svg" alt="smartplayer"  width=120 height=120  style="background-color:black"></a>
<a href="https://smartplayer.ru"><img src="https://static.tildacdn.com/tild3730-3634-4463-a464-333634323465/Group_20.svg" alt="smartplayer"  width=400 height=120  style="background-color:black"></a>
<!-- <a href="https://smartplayer.ru"><img src="https://static.tildacdn.com/tild3431-3533-4461-b365-386335306263/Group_101.svg" alt="smartplayer"  width=600 height=120  style="background-color:black"></a> -->
[![teleguard](https://teleguard.com/images/logo.png)](https://teleguard.com)[!
![DaKanji](https://dakanji.app/wp-content/uploads/thegem-logos/logo_a496404d3d63fd29f344146e428d0992_2x.png)](https://dakanji.app)
[![Pimosa](https://pimosa.app/_next/image?url=%2Flogo_final.png&w=64&q=75)](https://pimosa.app)
<a href="https://apidash.dev"><img src="https://apidash.dev/media/apidash.png" alt="API Dash" width=120 height=120  style="background-color:black"></a>
<a href="https://www.iptv-smarters-expert.app"><img src="https://is1-ssl.mzstatic.com/image/thumb/Purple221/v4/5b/28/ca/5b28ca83-3685-f6fb-70eb-a0205c6f1a87/AppIcon-0-0-85-220-0-5-0-2x.png/460x0w.webp" alt="IPTV Smarters Expert" width=120 height=120  style="background-color:black"></a>
<a href="https://app.nextv.fr"><img src="https://app.nextv.fr/images/nextv-logo.svg" alt="NexTv" width=180 height=180  style="background-color:black"></a>
[![onbon thinkshow](https://www.onbonbx.com/templates/default/images/xylogo.png)](https://www.onbonbx.com/download/software/ThinkShow)

[Q-SYS UCI Viewer](https://help.q-sys.com/Content/Schematic_Library/uci_viewer.htm)
[Diem](https://www.downloaddiem.com)
[easy live tv](https://github.com/aiyakuaile/easy_tv_live)
[Kazumi](https://github.com/Predidit/Kazumi)
[金嵘达科技](http://www.kingroda.com)
[爱玩宝](https://www.aiwanbao.com)




## License

- Free for opensource projects, QtAV donors and contributors: you can acquire a key from me. Can be commercial software
- Free for [Flutter](https://pub.dev/packages/fvp) users. A key is already included. Can be commercial softwares.
- Free for other non-commercial users: you can acquire a key from me.
- Commercial license for other users: a key for an app for a single platform or multiple platforms.
- Other users without a key: make sure your sdk is updated, otherwise you may see an QR image in the last frame.


License key generator and validator is [open source](https://github.com/wang-bin/appkey)