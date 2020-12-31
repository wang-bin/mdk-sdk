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
FFmpeg modules can be specified via environment var AVUTIL_LIB, AVCODEC_LIB, AVFORMAT_LIB, AVFILTER_LIB, SWRESAMPLE_LIB, SWSCALE_LIB, or SetGlobalOption() with key avutil_lib, avcodec_lib, avformat_lib, swresample_lib, swscale_lib, avfilter_lib. For example `SetGlobalOption("avutil_lib", "/opt/lib/libavutil.56.dylib")`

If ffmpeg any module is not set, it's searched in the following order
- current module dir > framework dir(apple) > system default search dir
- single ffmpeg library > ffmpeg modules w/ version > ffmpeg modules w/o version


## Swift
https://github.com/wang-bin/swiftMDK

## About SDK for macOS
SDK is built by Xcode 12.3 with
- ffmpeg: https://sourceforge.net/projects/avbuild/files/macOS/ffmpeg-master-macOS-lite.tar.xz/download

SDK can be used by any C or C++11 compiler, e.g. g++, clang

Support Apple sillicon

Support Metal and Vulkan renderer.

Support X11 if runtime libraries exist.

### macOS 10.15+
Executables download from internet are not able to run. Try
- xattr -dr com.apple.quarantine libffmpeg.4.dylib mdk.framework bin/*
- or run ./catalina.sh

### Runtime Requirements
Optional:
- MoltenVK
- EGL+GLESv2 via ANGLE project or PowerVR SDK. 0-copy rendering VideoToolbox frames is supported. EGL is automatically selected if exists. Can be disabled by environment var GL_EGL=0 or GLRenderAPI
- X11 via XQuartz


### Supported Graphics APIs:
- Metal: recommended
- OpenGL
- OpenGL ES2/3: via ANGLE or others. The default if EGL runtime is found.
- Vulkan


### Supported Video Decoders:
- FFmpeg. Direct rendering via property "pool=CVPixelBuffer"
- VT: videotoolbox hardware decoder. avcC, hvcC support. propertyes: threads, realTime, async, format. e.g. -c:v VT:format=nv12:async=1
- VideoToolbox: via ffmpeg

VT default use async mode, and the performance is better performance then FFmpeg's sync VideoToolbox

### Examples
gapless playback for any audio and video: glfwplay/sdlplay video1 video2 ...

N players for 1 video: multiplayers -share -c:v VideoToolbox -win N url

N videos and N players: multiplayers -share -c:v VideoToolbox url1 url2 ... urlN

N videos renderers for 1 player: multiwidnows url

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
- some examples using mdk sdk: https://github.com/wang-bin/mdk-examples
- OBS Studio plugin: https://github.com/wang-bin/obs-mdk
- QtMultimedia plugin: https://github.com/wang-bin/qtmultimedia-plugins-mdk

Copyright (c) 2016-2020 WangBin(the author of QtAV) <wbsecg1 at gmail.com>
Free for opensource softwares, non-commercial softwares, QtAV donors and contributors.