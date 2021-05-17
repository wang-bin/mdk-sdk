Change log:

0.11.1 - 2021-05-16

- Deprecate Player.setState(State), use Player.set(State)
- Add VideoFrame.save() to encode and save as a file
- Buffer range for realtime streams(rtsp, rtp etc.) is unlimited by default
- Unify pixel format channel map algorithm. Fix incorrect color for some formats(e.g. nv21)
- Ignore incorrect hdr metadata
- Allow renderVideo() in RenderCallback
- VT decoder:
  - Support jpeg, more prores profiles
  - Support h264, hevc GBRP 8bit input pixel format
- MFT:
  - Fix h264 profile check
  - Add property "blacklist", default is "mpeg4", mpeg4 is not well supported so disabled for now
- FFmpeg:
  - continue to decode by default if error ocurrs. can stop decoding by setting property "error=0"
  - Use 4.4 instead of master because of abi break
- Auto reset log handler to fix potential crash when exiting
- Fix seek on pause may never be executed forever without resume playback
- Fix endless wait if seek near EOF in loop mode
- Fix license check, appid is utf8. License generator and validator is opensource now as [appke](https://github.com/wang-bin/appkey)
- Fix crash if snapshot failed


0.11.0 - 2021-03-31

- API changes:
    - Add [setActiveTracks()](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs#void-setactivetracksmediatype-type-const-stdsetint-tracks)
    - Deprecate `javaVM(JavaVM*)`, use `SetGlobalOption("jvm", void*)` instead. [See Wiki](https://github.com/wang-bin/mdk-sdk/wiki/Global-Options)
    - Deprecate `setLogLevel(LogLevel)`, use `SetGlobalOption("logLevel", name or LogLevel or int value)` instead. See Wiki](https://github.com/wang-bin/mdk-sdk/wiki/Global-Options)
    - Deprecate `Player.setVideoDecoders(...)` and `Player.setAudioDecoders(...)`, use `Player.setDecoders(MediaType, ...)` instead
    - Add VideoFrame.isValid()
- Add ["dav1d"](https://github.com/wang-bin/mdk-dav1d) decoder. Default load libdav1d.5.dylib, libdav1d.so(android), libdav1d.so.5(linux), libdav1d.dll(windows), or set library name via environment var "DAV1D_LIB"
- Support frame step forward via `seek(1, SeekFlag::FromNow|SeekFlag::Frame)`, also support N frame forward
- `seek()` supports seeking to the last frame or the last key frame(has `SeekFlag::KeyFrame`) if target position > duration
- Improve video decoder switch
- setLogHandler(nullptr) once to log to std::clog, set again to disable log completely
- Fix potential endless wait if stop playback in loop mode
- Fix the first frame after seek is not the latest frame
- Fix music cover image not rendered if prepare from pos > 0
- Fix wrong position() and prepared callback invoked multiple times if play with an audio track file
- Fix the first frame rendered after seek is not the lastest frame
- FFmpeg:
    - Support avdevice via "avdevice://format:filename"
    - Support avformat options via url query, starts with "mdkopt=avformat", e.g. "some_url?mdkopt=avformat&fflags=nobuffer"


0.10.4 - 2021-02-17

- Support macCatalyst
- Support vulkan on apple silicon
- VT decoder:
    - Support VP9 on macOS 11+. Profile 0 and 2 are confirmed
    - Support more(all) semi-planar formats, output a format with the same chroma subsample size as original format, e.g. 'p410' for hevc yuv444p10le.
    - Fix high depth channel formats output error on apple silicon. It's r10g10a10a2 for 10bit Y plane, but not support yet in renderer, so use p010('x420')
    - Add "hardware" property to enable/disable hardware acceleration
    - Add "width" and "height" property
    - Support HDR in mkv
    - Reduce compressed packet copy
- VAAPI, VDPAU: fix not work since 0.10.2
- MFT video decoder: fix h264 constrained baseline profile check
- CUDA decoder: fix chroma format
- FFmpeg:
    - Fix a crash if avio open error
    - Fix "drop" option does not work correctly
- Improve decoder switch in paused state
- Fix can't switch to a new decoder via setVideoDecoders() since 0.10.0
- Fix a blank frame in gapless playback
- Fix 2 crashes in player dtor, 1 race in setNextMedia(), 1 race/crash if faile to open a media
- Examples:
    - Enable glfw for apple silicon


0.10.3 - 2020-12-31

- Player.setMedia() will stop previous media
- Default buffer range changes to 1000~2000ms
- Deprecate `foreignGLContextDestroyed()`, does nothing now. Use `setVideoSurfaceSize(-1, -1)` instead
- Support key-frame only decoding via env "KEY_FRAMES_ONLY=1" (per player option will be better)
- Support play/seek dynamic duration streams, e.g. recording mpeg ts
- Support 'x444'/p410 pixel format
- OpenGL:
    - smart resources release, no leak even if no context destroyed
    - fix external image in essl3 may crash on android
- VT decoder:
    - force nv12 for mpeg?video
    - support hevc yuv444p10le decoded format 'x444'
- Change macOS framework struct to support codesign better
- AMediaCodec decoder: use baseline as fallback of CBP(constrainted baseline) to fix decoder open error
- Fix crash when destroying player if use native surface
- Fix unable to seek if EOS is decoded
- FindMDK.cmake:
    - support xcframework
    - support android studio
- New swift binding: https://github.com/wang-bin/swiftMDK
- New android java wrapper and example: https://github.com/wang-bin/mdk-android


0.10.2 - 2020-11-18

- Support apple silicon(not tested on real device)
- Support swift language
- Support cocoapods for macOS via `pod 'mdk'`
- Add xcframework, including both macOS and iOS frameworks
- Add av1 support for CUDA decoder
- check pixel format support for mmal to fix yuv444p error
- mmal decoder: force copy if no 0-copy support
- Add ACES HDR tone map, via env `GPU_TONE_MAP=aces`
- Metal, d3d11, vulkan renderer support alpha blending if video has alpha channel
- Metal: fix crash if frame is invalid
- Fix a/v sync regression after seek since v0.10.1


0.10.1 - 2020-10-05

- Vulkan: support Player.snapshot()
- GLRenderAPI.egl/opengl/opengles combinations
- Fix Player.setProperty("audio.avfilter")
- D3D11 supports shared nt handle 0-copy rendering via decoder "D3D11:nthandle=1"
- Simplify ffmpeg runtime loading
- Fix some crashes and endless waits


0.10.0 - 2020-09-01

- API:
    - Add VulkanRenderAPI
- Support Vulkan: win32, macOS, android(buggy). Everything works except hardware decoder 0-copy rendering, only software decoders and hardware decoder with ":copy=1" are supported.
- Correct HDR trc if obviously wrong from decoder(mediacodec vp9)
- AMediaCodec:
    - Improve async mode
    - Fix blocks on some devices
- No need to call setLogHandler(nullptr) manually
- Remove redundant gpu color primaries convertion
- Fix D3D11 hevc decoder wrong result because of ignoring profile/level
- Fix D3D11 decoder + D3D11 0-copy rendering wrong result on RTX2060
- Partialy upport mac catalyst build


0.9.2 - 2020-07-29

- API:
    - Add version()
    - Add `Player.set(VideoEffect effect, const float& values, void* vo_opaque)` to set brightness, constrast, hue, saturation
- Metal: Fix viewport resize if create from user provided view
- D3D11/Metal: Fix stop playback does not clear background
- Fix XAudio2 crash on win7, fix leak
- HDR:
    - support HLG transfer function
    - use primaries from decoder(maybe wrong values) iff env "USE_METADATA_PRIMARIES" is 1
    - tone mapping improves
- Add AV1 for android "AMediaCodec" decoder
- Fix another A-B range loop endless waiting
- Vulkan WIP: apple, swapchain, debug, queue, apis, clear background render pass etc.


0.9.1 - 2020-06-30

- API:
    - D3D11RenderAPI.rtv can be a texture to reduce platform dependent user code, context is optional if rtv is set
    - Add GLRenderAPI.fbo, so no need to bind & restore fbo in user code
    - Add MDK_strdup(). Fix potential crashes if msvc build configuration(Debug) != SDK(Release)
- HDR:
    - BT.2390 is the default tone map curve. Controlled by env GPU_TONE_MAP=2390/hable
    - All decoder and renderer combinations has almost the same result
- MFT:
    - Read HDR metadata
    - Support AV1 decoder, need to install av1 extension from store: https://www.microsoft.com/en-us/p/av1-video-extension/9mvzqvxjbq9v
- Clear background on stop can be disabled by SetGlobalOption("videoout.clear_on_stop", 0)
- Default log level is Info. Must manually set to Debug to see more. playback progress log only appears in LogLevel::All
- Seek: ensure the last request will be executed. Useful for timeline preview
- Fix D3D11 backbuffer resize error
- Fix A-B range loop endless waiting if stop playback by user
- Fix change decoder error and wait forever near EOF
- Fix D3D11/Metal renderer crash if change from GPU decoder to CPU decoder
- Fix D3D11RenderAPI.feature_level
- Fix mute crash (avfilter)
- Fix crash if a chapter tile is empty
- Fix failed to save snapshot as png
- Fix win64 cmake search dir
- Deploy: requires vcruntime140_1.dll by win64
- WIP: vulkan


0.9.0 - 2020-05-28

- API: Add GLRenderAPI and MetalRenderAPI
- Support Metal on macOS and iOS. Lower CPU and GPU load.
- Windows:
    - Fix com initialization may affect cef
    - D3D11 support decode in 1 gpu and render in another (poor performance).
    - D3D11 upport some 16bit pixel formats if R16 is not supported
    - Add D3D11 debug mode for MFT decoder("MFT:debug=1") and D3D11 renderer
- Android:
    - Fix EGL load
    - Fix decoding EOS frame in sync and async mode
- Apple
    - Add debug symbol
    - (macOS) weak link to standard ffmpeg dylibs so no need to dlopen by user. see https://github.com/wang-bin/mdk-sdk/wiki/FFmpeg-Runtime#macos
    - Support software decoder direct rendering, decode to CVPixelBuffer via decoder "FFmpeg:pool=CVPixelBuffer". Less memory use.
    - VT decoder supports ProRes, decode into P010 frames
- FFmpeg:
    - Print ffmpeg logs in log mdk log handler. Fix multi-lines logs not print completely
    - Support reload via library handle
    - Custom frame pool
    - Add "sw_fallback" property
- Examples:
    - Modified apple official metal example: https://github.com/wang-bin/HelloTriangle/tree/master
    - QtQuick RHI example. supports d3d11, metal and opengl: https://github.com/wang-bin/mdk-examples/tree/master/Qt/qmlrhi


0.8.1 - 2020-04-30

- API:
    - Player.onSync() default interval is 10
    - Add options for creating D3D11RenderAPI
- CUDA: supports decoding yuv444 formats and 0-copy rendering
- Support rendering gray formats
- Fix MFT:d3d=11 texture leak
- Fix Player.setMute()
- Player.setState(State::Stopped) is much faster
- Fix seek error after setPlaybackRate() if sync to audio
- Apple: enable arc


0.8.0 - 2020-03-18

- API:
    - Add Player.mapPoint() to map coordinates between video frame and viewport
    - Aspect ratio change: negative is scale and crop, positive is scale without crop
    - Add Player.onSync() to support sync to user provided clock. Currently only video can sync to it
- D3D11 renderer:
    - Supports 16bit be formats
    - Convert to rgb by cpu if format is not supported
- Linux multi arch cross build. Less platform specific code
- Add V4L2M2M decoder
- Improve EGL
- Fix a crash on macOS when destroying player
- `setBackgroundColor()`: always draw background if color is valid. Fix regression since 0.7.0.
- Fix playback speed is too fast if resume after paused seek. Regression since v0.5.0
- Fix video only stream clock sync if change playback rate
- Fix wrong position when seeking (if media 1st pts > 0)
- GLX is not linked
- Use clang-8 for rpi to fix invalid armv6 so
- Fix undefined symbol for sunxi
- Enable cf guard for windows


0.7.0 - 2020-02-17

- API:
    - add `Player.setProperty()`
    - add `VideoFrame` class
    - add `Player.onFrame()` to get decoded frame, can be used by custom filters
    - support `MediaStatus::Seeking`
    - add snapshot [MediaEvent](https://github.com/wang-bin/mdk-sdk/wiki/Types#class-mediaevent)
    - `seek()` callback parameter is -2 if seek request is ignored
- ABI: no break
- `setBackgroundColor()`: if alpha is 0(default), you have to call `glClearColor`(or d3d11 api) manually.
- Add FindMDK.cmake in sdk lib/cmake dir, support multiple target architectures.
- Fix multiple D3D11 renderer crash
- Fix crash if audio device is not available
- Fix music with cover buffering progress error
- Fix last frames not rendered if prepare() from a position closed to end of stream.
- Player.setVideoSurfaceSize(-1, -1) can remove the renderer
- prepare() starts from 0 if requested start position > stream duration or duration is unknown
- Improve A-B loop if B is closed to or larger than end of file
- Fix block if A-B loop restarts when previous seeking is not finished
- Music with cover art: fix png not rendered. fix block if stop by user.
- Seek:
    - Fix SeekFromNow
    - Fix audio file read error after seek
    - When end of stream decoded and in paused state
    - Fix seek never work if previous seek failed
    - position() never change after a seek error or a frequent seek request
- snapshot: fix msvc crash
- OpenGL:
    - Save and restore blend states
    - Skip loading EGL if context is not created by mdk
- FFmpeg:
    - support avfilter complex filters via Player property ["video.avfilter" and "audio.avfilter"](https://github.com/wang-bin/mdk-sdk/wiki/Player-APIs#void-setpropertyconst-stdstring-key-const-stdstring-value)
    - Optimize audio filter if in/out parameters are the same
    - Improve video encoder
- VT decoder:
    - Fix the last frame not rendered
    - Support AnnexB streams
- Reduce exported classes
- Fix crashes, memory leaks in stress tests.
- Metal renderer: WIP
- Audio encoder: WIP


0.6.1 - 2020-01-05

- Improve D3D11 renderer, more pixel formats
- Player.snapshot() supports saving to file
- Support QSV decoder via DXVA2, and 0-copy rendering
- Subtitle WIP.
- Encoder WIP.
- Fix endless wait in loop mode
- Environment var name change: GL_MMAL_FORMAT=>MMAL_GL_FORMAT, GL_VAAPI=>VAAPI_GL, GL_VDPAU=>VDPAU_GL


0.6.0 - 2019-12-02

- D3D11 Renderer: now has almost the same features as OpenGL renderer
    - HDR tone mapping support
    - Support UWP. `ICoreWindow` or `ISwapchainPanel` can be used as the surface of `Player.updateNativeSurface()`
    - Zero copy rendering for hardware decoders, including d3d11, dxva2 and cuda based decoders.
    - Add env vars "SWAPCHAIN_BUFFERS", "DXGI_ADAPTER_RENDER" and "GPU_DEBUG" to control swap chain buffers adapter index and debug layer
    - Support feature level 9.1~12.1(default), controlled by env "D3D_FEATURE_LEVEL_RENDER"
    - Save and restore pipeline states before and after rendering
    - Support foreign context provided by user via `Player.setRenderAPI()`, `D3D11RenderAPI.context` and `D3D11RenderAPI.rtv` must be provided
    - Remove restriction of calling `Player.setRenderAPI()` before any other apis have `vo_opaque` parameter. `updateNativeSurface()` still have to be called after `setRenderAPI()`
    - Support more pixel formats, including nv12, p010 etc. Packed formats with 3 channels are not supported by d3d11 without cpu convertion, leaves them as unsupported.
- MFT: decoder device feature level can be set by property "feature_level"
- Reduce cpu load on pause
- Range loop: fix seek to A failure
- macOS:
    - Fix ui apis called on non-ui thread when creating CGL context(crash on macOS 10.15+)
    - Weak link to libffmpeg.4.dylib because macOS 10.15+ disallow dlopen. also can be replaced by user provided ffmpeg libraries(avutil, avcodec etc.) at runtime via `SetGlobalOption("avutil", (void*)handle)`
- FFmpeg:
    - Set ffmpeg module handle via `SetGlobalOption("name", (void*)handle)`, where name is avutil, avcodec, avformat etc.
    - Fix crash if custom ffmpeg libraries are not complete. Required modules are "avutil", "avformat", "avcodec"
    - D3D11 decoder improve
    - Fix VAAPI seek crash cause by wrong ref count


0.5.0 - 2019-11-03

- ABI Changes:
    - PrepareCallback return type change in Player.prepare()
    - Player.snapshot() callback return type change. Return a file path to save as file(not implemented yet)
    - Add SeekFlag for prepare(), setNextMedia() and gaplessSwitch()
- APIs Changes:
    - Add RenderAPI.h: provides necessary informations to use a graphics api other than OpenGL
    - Add Player.setRenderAPI(): select platform graphics api for video rendering. Now OpenGL(default) and D3D11 are supported.
    - Add version macros
- New Features:
    - Experimental D3D11 rendering support. Now can render frames from software decoders. Color is not precise as OpenGL. Only the context created internally from a HWND via updateNativeSurface is tested. Foreign contexts may work, not tested.
- Improve seeking performance, fix unchanged display when seeking continuously. Now it's close to mpv, and should be better than most players like potplayer, vlc, mpc-hc etc.
- Fix seek position if media start time > 0
- Accurate seek is the default for the start position of prepare(), setNextMedia() and gaplessSwitch()
- OpenGL: Skip uploading video frame to gpu when redrawing
- setState(State::Stopped) now clears video renderer viewport and releases video renderer resources
- Fix stopping playback is not executed immediately
- setState(State::Stopped) now releases host and gpu resouces and clear background color. Normal playback end does not, and still keep the last frame displayed
- Fix setState() sometimes does not work
- MFT Decoder:
    - Disable low latency by default only for hevc. Previous release turned off low latency mode for all codecs, then h264 decoding may be too slow
    - Add property "ignore_profile" and "ignore_level"
- Add FFmpeg decoder property "drop" to control decoder frame dropping when seeking
- glfwplay example:
    - new seek options: `-seek_step`, `-seek_any`
    - support d3d11 rendering using `-d3d11 -gfxthread`


0.4.1 - 2019-10-08

- macOS: fix glx weak link
- support ubuntu >= 14.04
- load vaapi dynamically
- improve vaapi host map, control via env var VAIMAGE_DERIVE, VAIMAGE_FORMAT
- fix many playback loop bugs when more tracks are enabled
- fix too many packets buffered when decoding the 1st frame
- MFT: disable low latency to fix frames out of order
- subtitle support WIP.
    - decode embedded subtitle tracks via avcodec
    - decode loop and thread
- FFmpeg
    - versioned dso is preferred
    - reload ffmpeg symbols if dso is changed by SetGlobalOption()
    - log level is controlled by SetGlobalOption("ffmpeg.loglevel", val), val can be "quiet", "panic", "fatal", "error", "warning", "info", "verbose", "debug", "trace"


0.4.0 - 2019-09-04

- API:
    - add Player.setRange(a, b)
    - add Player.setLoop(count), onLoop(callback)
- Reduce pixel format storage
- Fix onEvent() can not add multiple callbacks
- Support windows on arm64
- VA-API: support map to host
- GL: support creating ES context from WGL
- avglue plugin is now merged into main library
- FFmpeg code is no longer embedded into mdk by default. External ffmpeg4.0+ is loaded automatically. Distributing mdk sdk is easier especially on linux


0.3.1 - 2019-08-15

- fix user stop block
- fix some bugs at eof, e.g. unable to seek
- fix setLoop(0) can not disable looping
- support clang-cl 9.0
- c++ api: support g++ 4.9
- vaapi: sync surface after exporting drm handle
- improve ci. now nightly packages are uploaded automatically to https://sourceforge.net/projects/mdk-sdk/files/nightly
- now mdk can be installed via nuget in visual studio. https://www.nuget.org/packages/mdk


0.3.0 - 2019-08-01

- support A-B loop via setLoop()
- API:
    - fix player.mediaInfo() crash
    - add chapters description in MediaInfo
    - add setLoop()
- GL:
    - add hdr tone mapping. can be disabled by env var "GL_TONE_MAP=0"
    - can create wgl context with specified version and profile
    - improve glsl
- raspberry pi:
    - fix legacy driver check. gl and mmal works correctly on all drivers
    - load libwayland-egl.so.1 when needed
    - mmal zero copy rendering supports yuv textures. not perfect. not the default. enabled by "GL_MMAL_FORMAT=yuv420p"
- MFT(windows media foundation):
    - fix dolby decoder output format
    - input/output type index can be specified by property, example: decoder name is "MFT:in_type=0:out_type=0"
- add missing metadata in MediaInfo
- improve EOS handling in demux thread
- remove terminal null in log
- videotoolbox: stop decoding if decoded frame is invalid
- stop annexb conversion if error occurs
- fix video output drop rate is not desired value
- fix crash if cuda is not available when using CUDA decoder
- fix xaudio2 crash
- fix iOS 32bit min version


0.2.3 - 2019-07-01

- muxer: skip unwanted stream packets
- GL:
    - support gbrp formats
    - improve yuv to rgb
    - xyz gamma correction
- generic color space, trc, primaries support. done in renderer, demuxers and decoders(FFmpeg, VT, AMediaCodec, MFT)
- android AudioTrack: do not use deprecated 7.1 channel value, which may not work in new OSes
- FFmpeg:
    - fix sw format after seek
    - check hw pixfmt of decoded frame, fix sw fallback
    - support avcodec options via property, e.g. FFmpeg:thread=2
- fix annexb check for CUDA, MFT, AMediaCodec decoder
- try next decoder set by user if failed to decode a frame
- AMediaCodec decoder:
    - profile, level and capabilities check before using a codec
    - fix nv12 plane line size in copy mode
    - async mode support
    - detect decode error
- VT decoder(VideoToolbox): add property "copy"
- MFT decoder:
    - apply property "copy", "pool" on the fly
    - fix annexb check
- raspberry pi:
    - enable builtin mmal decoder. decoder name is "mmal", while FFmpeg's is "MMAL"


0.2.2 - 2019-06-05

- API changes:
    - add Player.record()   to record while playing
    - add SetGlobalOption(), can be used to set ffmpeg runtime paths via key "avutil_lib", "avcodec_lib" etc.
- ABI break: no
- NEW:
    - add NV24/42
    - GL: support xyz12le/be
    - MFT: support D3D11 for win7
    - support color space, primaries, trc, range, hdr metadata for VideoFrame, MediaInfo, decoders(except android) etc.
    - support HDR10 for windows GLES2/3(ANGLE) via environment var "D3D11_GL=eglpbuf"
    - support muxing
- fix m3u check
- GL: scale high depth color depends on channel shift
- ci: add azure macOS + iOS build
- iOS: fix arm32 c++17 build(aligned allocate), disable private symbol texImageIOSurface
- free for gpl softwares


0.2.1 - 2019-04-28

- support win arm64 via clang, support llvm-rc
- AVGlue:
    - support user specified FFmpeg runtime libraries instead of built-in ones via environment var: AVUTIL_LIB, AVCODEC_LIB, AVFORMAT_LIB, AVFILTER_LIB, SWRESAMPLE_LIB
    - add FFmpeg decoder property "codec": glfwplay -c:v FFmpeg:codec=...
- Fix MFT p010 frame stride
- Fix cuda api

0.2.0 - 2019-04-01

- API:
    - add setBufferRange()
    - add/removeListener()=>onEvent()
    - add MediaInfo
    - add snapshot()
    - add setBackgroundColor()
- C ABI: should be stable
- New:
    - support dropping outdated packets for realtime streams
    - support fast accurate seek
    - auto rotate
    - switch decoder on the fly
    - first frame rendered event
- Fix m3u8 demux
- Fix a/v sync if audio thread exits earlier
- Fix incorrect buffering progress
- Fix undefined ndkmedia symbols at runtime and crash
- rpi: add native mmal video decoder(disabled now)
- rpi: fix eglimage cache
- rpi: start to adding omx
- MFT: check h264 constraints


0.1.0 - 2019-02-25

- ABI and API change. Single C/C++ SDK is compatible with any C++11 compiler and runtime. Library APIs moves into abi namespace.
- Hide more unnecessary symbols
- Simplify udio channel map
- Do not render audio if no audio device. crash fix
- Fix buffered bytes
- Implement CUDA decoder. Should be better than FFmpeg's CUVID.
- Use exported symbol `void* GetCurrentNativeDisplay()` in main to support vaapi/vdpau+x11egl interop


0.0.10 - 2019-01-28

- Individual audio tracks support.
- MFT decoder improve
    - crop visual area
    - decoded frame copy mode option
    - fix crashes
    - d3d11 0-copy rendering jitter fix
    - add audio decoders: aac, mp3 support
    - minimize IMFMediaBuffer copy
    - fix undefined MFCreateTrackedSample runtime error on win7
- P010, P016 rendering in OpenGL
- buffering event
- Apple: disable flat namespace
- unify decoder properties: "copy", "format"
- support win32 x86: api ptr type, float point compare
- MediaStatus changes
- fix android mediacodec arm64 lto link
- fix annexb packet filter(affects mediacodec)
- mediacodec: support yuv420p, support level 28 ndk apis and metadata, print decoder name
- vaapi: support info/error callback
- avcodec: fix lifetime of hwcontext(hwdec crash)
- gl: recreate texture before changing parameters to fix wrong display if hwdec=>swdec

0.0.9 - 2018-12-05

- dynamic load vdpau in GLVA module
- P010 for d3d11 decoded frames
- enable thin-lto for all
- fix crash if no egl dll
- fix iOS link error
- pulseaudio wip
- Audio backend refactor: async push backend
- exit dsound thread via event
- Add missing onOpen, onClose, onFlush in video decoders
- Add VideoToolbox(name is "VT") for macOS/iOS, support async mode. h265 hvcC, h264 avcC stream are supported, nal is not yet.
  Better performance than FFmpeg's videotoolbox.
  propertyes: threads, format, realTime, async
- Decode EOS only once to fix MediaCodec block in the end.
- Add MFT based video decoder for Win32(Vista+) and UWP. Supports h264, hevc, vp8/9 etc. Supports software decoding, dxva/d3d11 gpu acceleration.
- Add threads property for FFmpeg based decoders.
- Android: support posting messages from native code. try to load stl.
- WinRT/UWP: support IStorageFile


0.0.8 - 2018-10-07

- GL:
    - do not fill background color
    - fix wrong color if video changes
    - fix redraw in a new gl context
    - restore viewport, bo, shader program after rendering to support embedding in other frameworks
    - fix global vbo attributes changes
    - multi-thread improve
    - support NSWindow
    - fix resizing on macOS10.14
- player
    - Add volume, mute, playback rate, vide scale(including mirror) api
    - add getVideoFrame() to retreive currently rendered frame
    - surface type parameter for updateNativeWindow()
    - default preload policy change
    - render callback parameter to support multiple outputs
- fix gapless switch
- fix buffered duration
- apple: disable time pitch effect which results in inaccurate callback invoking time after AudioQueueReset
- playback rate is implemented in avfilter
- no sw fallback when opening hw decoder
- print build information
- fix old packet is enqueued after seek
- GLVA:
    - vaapi: fallback to drm interop if drm2 is not implemented
    - d3d11: always render mapped nv12 textures in rg format to fix es2 rendering(11 feature level 9.3)
- win32/winrt: observe surface size change via foreign window handle and less user code
- build: icf, clang-cl on windows, libc++ etc.
- test: add glfw, x11 example


0.0.7 - 2018-07-31

- support sunxi cedarv decoder and 0-copy rendering via UMP
- add mediacodec audio decoder
- unify mediacodec audio & video decoder
- improve mediacodec video decoder
- create decoder with options string
- buffering progress in duration
- drop frame less. control via env "VO_DROP"
- no MTA requirement for xaudio2
- player: support multiple renderers
- API: player.setAudioDecoders(...), tiled pixel format, seek flag
- build: improve linux cross build with lib++, support winrt via clang
- GLVA:
    - use native video buffer template except apple
    - vaapi + drm(prime) support
    - fix mapped texture reuse for multi-renderers rendering(except d3d)


0.0.6 - 2018-06-02

- support clang-cl host build and cross build for windows
- support opensource gcc on macOS
- improve Packet.buffer
- support rendering frame whose vertical stride > height
- fix and improve VideoFrame ctor
- fix seek block because of long time sleep
- add MediaStatus::PreparedMedia, fix mediaStatus() bugs
- frame boost options for FrameReader and player prepared callback
- fix wrong frame displayed in gapless switch via frame boost option
- Android AudioTrack support
- Android MediaCodec video decoder support, via ndk api implemented in ndk or jni (JMI+AND project)
- GLVA:
    - test D3D11 nv12 SR texture support
    - map to host support: d3d9, d3d11, vdpau
    - CUDA stream support and enabled by default
    - fix android context change check
    - fix MMAL pool is used for mesa vc4 environment
- AVGlue:
    - use new api avcodec_get_hw_frames_parameters
    - set texture flags via hwframesctx to enable d3d11va-eglstream 0-copy
    - improve Buffer and AVBufferRef, support offset
    - fix mkv packet decode error in ffmpeg4.0+
    - fix mediacodec because of ref leak
    - use CUDA stream shared from glva native buffer pool


0.0.5 - 2018-05-05

- video decoder supports glva via wrapper
- fix mapped host frame stride and format
- qr code overlay and license check module
- OpenSL use system stream type and the sound is louder
- ALSA: fix reopen error
- Support direct sound
- Fix rendering audio with invalid padding data
- GL: grab rendered frame, user shader api
- player: no currentMediaChanged in dtor to ensure accessing player object is safe
- FrameReader: improve AOT frame boost(no api now), improve state update and no more unexpected dead blocks
- Gapless switch improvements(mostly in audio)
- log is default disabled, set null handler behavior change
- build: cmake 3.5+ is required, ubsan, fix header install
- GLVA
    - api change: support multiple textures, no more map callback, frame size parameter
    - NativeVideoBuffer wrapper for c api
    - Fix texture reuse optimization(apple, d3d, mmal)
    - add VA-API interop with X11 Pixmap, for both  EGL and GLX
    - add VDPAU interop with X11 Pixmap, and GLX extension, for both  EGL and GLX
    - D3D9 interop with WGL works now
    - support D3D11 interop with WGL
    - D3D11 interop with EGLStream works now and it becomes the default
    - D3D11 supports texture as egl client buffer(requires ANGLE master)
    - fix potential EGLSurface leak in CVPixelBuffer interop
- AVGlue
    - improve linking static ffmpeg on windows
    - support VA-API, VDPAU
    - less deprecated apis
    - fix AVFrame leak in filter, use smart ptrs for av types
    - fix the case avpacket data is different from buf.data


0.0.4 - 2018-04-07

- requires cmake3, fix x64
- gnu stl is default for rpi
- works with vs2013 again(wgl only)
- frame drop api, no implementation
- support ALSA, it's default for linux
- improve audio renderer: flush, pause, delay, timestamp, unified, write
- remove audio renderer open/close apis. reopen internally when necessary
- improve a/v sync, support no active audio track
- opengl context local storage improvements: per object, custom creator and initializer etc.
- d3d11 interop with angle egl, for desktop and uwp
- fix teared content in d3d11 interop
- apple CVPixelBuffer interop with ANGLE EGL
- disable opengl shader cache sharing
- fix 16bit rendering in ES3
- videorenderer: fix 2d transform matrix(aspect ratio), optimize matrix uploading
- GLVA: refactor, unify and simplify context change handling
- support CUDA
- frame capture api without implementation
- avglue: new ffmpeg hwconfig apis, support nvdec, hw device ctx from us, hw copy decoder, mediacodec hwcontext
