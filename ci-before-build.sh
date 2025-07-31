NDK_HOST=linux
FF_EXTRA=-clang
FFPKG_EXT=tar.xz

echo "EXTERNAL_DEP_CACHE_HIT: ${EXTERNAL_DEP_CACHE_HIT}"
echo "DEVTOOLS_CACHE_HIT: ${DEVTOOLS_CACHE_HIT}"

du -hc external

tolower(){
  echo "$@" | tr ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz
}

crt_extra=$(tolower ${CRT_EXTRA})

if [[ "$TARGET_OS" == mac* || "$TARGET_OS" == iOS* || "$TARGET_OS" == tvOS* || "$TARGET_OS" == xr* || "$TARGET_OS" == vision* || "$TARGET_OS" == android ]]; then
    FF_EXTRA=
fi
if [[ "$TARGET_OS" == "win"* || "$TARGET_OS" == "uwp"* ]]; then
  FF_EXTRA=-vs2022${crt_extra}
  FFPKG_EXT=7z
fi
if [ `which dpkg` ]; then # TODO: multi arch
    pkgs="sshpass cmake ninja-build p7zip-full"
    #wget https://apt.llvm.org/llvm.sh
    if [[ "$TARGET_OS" != android ]]; then
        #bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
        wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | sudo apt-key add -
        source /etc/os-release
        sudo add-apt-repository -y "deb http://apt.llvm.org/${VERSION_CODENAME}/ llvm-toolchain-${VERSION_CODENAME} main"
        sudo apt update
        pkgs+=" llvm-${LLVM_VER}-tools clang-${LLVM_VER} clang-tools-${LLVM_VER} clang-tidy-${LLVM_VER} lld-${LLVM_VER} libc++-${LLVM_VER}-dev libclang-rt-${LLVM_VER}-dev"
    fi
    if [ "$TARGET_OS" == "linux" ]; then
        pkgs+=" libopenal-dev libsdl2-dev"
        #pkgs+=" libegl1-mesa-dev libgles2-mesa-dev libgl1-mesa-dev libgbm-dev libx11-dev libwayland-dev libasound2-dev libopenal-dev libpulse-dev libva-dev libvdpau-dev"
    elif [ "$TARGET_OS" == "sunxi" -o "$TARGET_OS" == "raspberry-pi" ]; then
        pkgs+=" binutils-arm-linux-gnueabihf"
    fi
    sudo apt install -y $pkgs
elif [ `which brew` ]; then
    export HOMEBREW_NO_AUTO_UPDATE=true
    #time brew update --preinstall
    export HOMEBREW_NO_AUTO_UPDATE=1
    pkgs="ninja vulkan-headers dav1d md5sha1sum" # p7zip  gnu-tar
    #pkgs+=" cmake" # visionOS simulator requires cmake 3.28.4
    if [[ "$DEVTOOLS_CACHE_HIT" != "true" ]]; then
        pkgs+=" hudochenkov/sshpass/sshpass"
    fi
    if [ "$TARGET_OS" == "macOS" ]; then
        pkgs+=" glfw sdl2"
        echo "$TARGET_ARCH" |grep arm >/dev/null || { # FIXME: arm64 host build
          pkgs+=" xquartz pulseaudio" # no more cask
        }
    fi
    time brew install $pkgs
    type -a cmake
    NDK_HOST=darwin
fi

OS=${TARGET_OS/r*pi/rpi}
OS=${OS/*store/WinRT}
OS=${OS/*uwp*/WinRT}
OS=${OS%%-*}
#OS=${OS/Simulator/} #
[ "$TARGET_OS" == "linux" ] && OS=Linux
mkdir -p external/{bin,lib}/$OS

if [[ "$EXTERNAL_DEP_CACHE_HIT" != "true" ]]; then
  FFPKG=ffmpeg-${FF_VER}-${TARGET_OS}${FF_EXTRA}-lite${LTO_SUFFIX}
  curl -kL -o ffmpeg-${TARGET_OS}.${FFPKG_EXT} https://sourceforge.net/projects/avbuild/files/${TARGET_OS}/${FFPKG}.${FFPKG_EXT}/download
  if [[ "${FFPKG_EXT}" == 7z ]]; then
    7z x ffmpeg-${TARGET_OS}.${FFPKG_EXT}
  else
    tar Jxf ffmpeg-${TARGET_OS}.${FFPKG_EXT}
  fi
  #find ${FFPKG}/lib -name "libav*.so*" -o  -name "libsw*.so*" -delete
  find ${FFPKG}/lib -name "libffmpeg.a" -delete # FIXME: linking to libffmpeg.a(relocatable obj) by ci results in larger binary size
  cp -af ${FFPKG}/lib/* external/lib/$OS
  cp -af ${FFPKG}/include external/
  cp -af ${FFPKG}/bin/* external/bin/$OS # ffmpeg dll

  if [ "$TARGET_OS" == "sunxi" ]; then
      mkdir -p external/lib/sunxi/armv7
      cp -af ${FFPKG}/lib/* external/lib/sunxi/armv7 #single arch package
  elif [ "$TARGET_OS" == "windows-desktop" ]; then
      # TODO: download in cmake(if check_include_files failed)
      curl -kL -o vk.zip https://github.com/KhronosGroup/Vulkan-Headers/archive/main.zip
      7z x vk.zip
      cp -af Vulkan-Headers-main/include/* external/include/
  fi

  if [[ "$TARGET_OS" == "win"* || "$TARGET_OS" == "uwp"* || "$TARGET_OS" == macOS ]]; then
    mkdir -p external/include/{EGL,GLES{2,3},KHR}
    for h in GLES2/gl2.h GLES2/gl2ext.h GLES2/gl2platform.h GLES3/gl3.h GLES3/gl3platform.h; do
      curl -kL -o external/include/${h} https://www.khronos.org/registry/OpenGL/api/${h}
    done
    for h in EGL/egl.h EGL/eglext.h EGL/eglplatform.h KHR/khrplatform.h; do
      curl -kL -o external/include/${h} https://www.khronos.org/registry/EGL/api/${h}
    done
  fi
  if [[ "$TARGET_OS" == "win"* || "$TARGET_OS" == macOS || "$TARGET_OS" == "linux" ]]; then
    curl -kL -o R3DSDK.7z https://sourceforge.net/projects/mdk-sdk/files/deps/r3d/R3DSDK.7z/download
    7z x R3DSDK.7z -oexternal
  fi
fi

curl -kL -o libmdk-dep.zip https://nightly.link/wang-bin/devpkgs/workflows/build/main/libmdk-dep.zip
7z x libmdk-dep.zip
7z x dep.7z
cp -af dep/* external/

if [[ "$SYSROOT_CACHE_HIT" != "true" ]]; then
  if [[ "$TARGET_OS" == "win"* || "$TARGET_OS" == "uwp"* ]]; then
    wget https://sourceforge.net/projects/avbuild/files/dep/msvcrt-dev.7z/download -O msvcrt-dev.7z
    echo 7z x msvcrt-dev.7z -o${WINDOWSSDKDIR%/?*}
    7z x msvcrt-dev.7z -o${WINDOWSSDKDIR%/?*}
    wget https://sourceforge.net/projects/avbuild/files/dep/winsdk.7z/download -O winsdk.7z
    echo 7z x winsdk.7z -o${WINDOWSSDKDIR%/?*}
    7z x winsdk.7z -o${WINDOWSSDKDIR%/?*}
    ${WINDOWSSDKDIR}/lowercase.sh
    ${WINDOWSSDKDIR}/mkvfs.sh
  fi

  if [ "$TARGET_OS" == "sunxi" -o "$TARGET_OS" == "raspberry-pi" -o "$TARGET_OS" == "linux" ]; then
    wget https://sourceforge.net/projects/avbuild/files/${TARGET_OS}/${TARGET_OS/r*pi/rpi}-sysroot.tar.xz/download -O sysroot.tar.xz
    tar Jxf sysroot.tar.xz
  fi

  if [ "$TARGET_OS" == "android" -a ! -d "$ANDROID_NDK_LATEST_HOME" ]; then
    wget https://dl.google.com/android/repository/android-ndk-${NDK_VERSION:-r25b}-${NDK_HOST}-x86_64.zip -O ndk.zip
    7z x ndk.zip -o/tmp &>/dev/null
    mv /tmp/android-ndk-${NDK_VERSION:-r25b} ${ANDROID_NDK:-/tmp/android-ndk}
  fi
fi
