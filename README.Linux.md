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
- Integrated with any platform native ui apps, gui toolkits or other apps via [OpenGL, D3D11, Vulkan and Metal](https://github.com/wang-bin/mdk-sdk/wiki/Render-API) ([OBS](https://github.com/wang-bin/obs-mdk), [Flutter](https://pub.dev/packages/fvp), [Qt](https://github.com/wang-bin/mdk-examples/tree/master/Qt), [SDL](https://github.com/wang-bin/mdk-examples/tree/master/SDL), [GLFW](https://github.com/wang-bin/mdk-examples/tree/master/GLFW), [SFML](https://github.com/wang-bin/mdk-examples/tree/master/SFML) etc.) easily
- [HDR display, HDR to SDR and SDR to HDR tone mapping](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs#player-setcolorspace-value-void-vo_opaque--nullptr)
- [Seamless/Gapless media and bitrate switch for any media](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs#player-setcolorspace-value-void-vo_opaque--nullptr)
- Optimized Continuous seeking. As fast as mpv, but much lower cpu, memory and gpu load. Suitable for [timeline preview](https://github.com/wang-bin/mdk-sdk/wiki/Typical-Usage#timeline-preview)
- [Smart FFmpeg runtime, dynamic load, compatible with 4.x~6.x abi](https://github.com/wang-bin/mdk-sdk/wiki/FFmpeg-Runtime)
- Professional codecs: GPU accelerated [HAP](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#hap) codec rendering, [Blackmagic RAW](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#braw), [R3D](https://github.com/wang-bin/mdk-sdk/wiki/Decoders#r3d)


## About SDK for Linux
SDK is built by clang 16.0 with
- ffmpeg: https://sourceforge.net/projects/avbuild/files/linux/ffmpeg-master-linux-clang-lite.tar.xz/download
- libc++ 16.0

SDK can be used by any C or C++11 compiler, e.g. g++, clang

### [Runtime Requirements](https://github.com/wang-bin/mdk-sdk/wiki/System-Requirements#linux-desktop-raspberry-pi-64bit)

ubuntu>=14.04(maybe 12.04)

- glibc >= 2.14
- libc++1, libc++abi1: not using gnu stl because libc++ has better compatibility. previous sdks depend on glibc++ 3.4.22(g++6)
- libva version 2 or 1: libva2, libva-x11-2, libva-drm2 or libva1, libva-x11-1, libva-drm1. Running `apt install vainfo` will install these
- libasound2, libpulse0
- libwayland-client0
- libgbm1
- libgl1-mesa-glx

Optional:
- libegl1-mesa: egl context
- libvdpau1: vdpau rendering. (required by ffmpeg decoder)
- libwayland-egl1: wayland surface and egl context support
- libass5~9 to support subtitle
- libopenal1
- libsdl2: sdlplay example

### Environment Vars:
- GL_EGL: 0 = use glx context, 1 = use egl context (if created by mdk)
- GL_ES: 0 = use opengl, 1 = use opengl es (if created by mdk)
- VDPAU_GL: video = interop with video surface, output = interop with output surface, pixmap = interop with x11 pixmap(required by egl from x11)
- VAAPI_GL: x11 = interop with glx/egl(via x11 pixmap), drm = interop with drm prime, drm2 = interop with drm prime2
- CUDA_STREAM: 0/1
- CUDA_PBO: 0/1
- CUDA_HOST: 0/1
- CUDA_DEVICE: number

### [Supported Graphics APIs:](https://github.com/wang-bin/mdk-sdk/wiki/Render-API)
- OpenGL
- [OpenGL ES2/3](https://github.com/wang-bin/mdk-sdk/wiki/OpenGL-Support-Matrix): via EGL, GLX, ANGLE or others. the default if EGL is available.
- Vulkan: broken now

### [Supported Decoders:](https://github.com/wang-bin/mdk-sdk/wiki/Decoders)
- FFmpeg, VDPAU, VAAPI, CUDA, QSV(not tested), NVDEC
- command line: -c:v decodername

### DRM Prime
RaspberryPi OS system ffmpeg provides hevc and v4l2m2m drm_prime frame output, you can use system ffmpeg(delete libffmpeg.so.* in sdk package) with OpenGLES(desktop GL does not support hevc) contexts created from EGL to get maximum performance. glfwplay option to test: -c:v V4L2M2M,FFmpeg:hwcontext=drm -gl. It's recommend to call `SetGlobalOption("eglimage.reuse", 1)` or decoder option `reuse=1` to get better performance, glfwplay option is `-eglimage.reuse 1`.

RaspberryPi OS rendering performance is poor, you may have to disable log, log to file or minimize terminal to get higher fps, otherwise rendering log may slow down video rendering.

### Examples
GL Context
- Created by MDK: glfwplay -gl:opengl=1, glfwplay -gl:opengl=1:egl=1, glfwplay -gl, mdkplay, x11win
- Foreign Context: glfwplay, multiplayers, multiwindows (via glfw), sdlplay(via sdl)

Gapless Playback for Any Media:
- mdkplay(or glfwplay/window/sdlplay) file file2 ...

N players for 1 video: multiplayers -share -win N url

N videos and N players: multiplayers -share url1 url2 ... urlN

N videos renderers for 1 player: multiwidnows url

### Use in CMake Projects
```
	include(mdk-sdk-dir/lib/cmake/FindMDK.cmake)
	target_link_libraries(your_target PRIVATE mdk)
```

## Source code:
- [some examples using mdk sdk](https://github.com/wang-bin/mdk-examples)
- [OBS Studio plugin](https://github.com/wang-bin/obs-mdk)
- [QtMultimedia plugin](https://github.com/wang-bin/qtmultimedia-plugins-mdk)
- [MFT decoder module](https://github.com/wang-bin/mdk-mft)
- [dav1d decoder module](https://github.com/wang-bin/mdk-dav1d)
- [Blackmagic RAW](https://github.com/wang-bin/mdk-braw)
- [R3D RAW](https://github.com/wang-bin/mdk-r3d)

Copyright (c) 2016-2023 WangBin(the author of QtAV) <wbsecg1 at gmail.com>
Free for opensource softwares, non-commercial softwares, QtAV donors and contributors.