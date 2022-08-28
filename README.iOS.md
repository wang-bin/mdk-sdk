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

## Swift
https://github.com/wang-bin/swiftMDK

## About SDK for iOS
SDK is built by Xcode 13 with
- ffmpeg: https://sourceforge.net/projects/avbuild/files/iOS/ffmpeg-master-iOS-lite.tar.xz/download
- Minimal system: iOS 8.0
- Support Metal renderer

### [Supported Graphics APIs:](https://github.com/wang-bin/mdk-sdk/wiki/Render-API)
- Metal: recommended
- [OpenGL ES2/3](https://github.com/wang-bin/mdk-sdk/wiki/OpenGL-Support-Matrix)

### [Supported Decoders:](https://github.com/wang-bin/mdk-sdk/wiki/Decoders)
- FFmpeg. Direct rendering via property "pool=CVPixelBuffer"
- VT: videotoolbox hardware decoder. h264, hevc support. propertyes: threads, realTime, async, format, hardware, width, height. e.g. `player.setVideoDecoders({"VT:format=nv12:async=1", "FFmpeg"})`
- VideoToolbox: via ffmpeg

### Use in CMake Projects
```
	include(mdk-sdk-dir/lib/cmake/FindMDK.cmake)
	target_link_libraries(your_target PRIVATE mdk)
```

### Use in Xcode
Choose any of
- Add mdk.xcframework to your project(Embed & Sign)
- install via cocoapods `pod 'mdk'`

#### Code Sign
Choose any of
- In `Build Settings` add `--deep` to `Other Code Signing Flags`
- (Recommended) In `Build Phase`, add a `New Run Script Phase` with content `[ -n "$CODE_SIGN_IDENTITY" ] && find "$BUILT_PRODUCTS_DIR" -depth -name "libffmpeg*.dylib" -exec codesign -i mdk.framework.ffmpeg -f -vvvv -s"${EXPANDED_CODE_SIGN_IDENTITY}" ${OTHER_CODE_SIGN_FLAGS:-} --preserve-metadata=identifier,entitlements,flags {} \;`

## Source code:
- [some examples using mdk sdk](https://github.com/wang-bin/mdk-examples)
- [OBS Studio plugin](https://github.com/wang-bin/obs-mdk)
- [QtMultimedia plugin](https://github.com/wang-bin/qtmultimedia-plugins-mdk)
- [MFT decoder module](https://github.com/wang-bin/mdk-mft)
- [dav1d decoder module](https://github.com/wang-bin/mdk-dav1d)

Copyright (c) 2016-2022 WangBin(the author of QtAV) <wbsecg1 at gmail.com>
Free for opensource softwares, non-commercial softwares, QtAV donors and contributors.