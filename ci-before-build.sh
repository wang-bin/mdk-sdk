LLVER=${LLVM_VER:-11}
NDK_HOST=linux
FF_EXTRA=-clang
GLFW_VER=3.3.2

echo "EXTERNAL_DEP_CACHE_HIT: ${EXTERNAL_DEP_CACHE_HIT}"
echo "DEVTOOLS_CACHE_HIT: ${DEVTOOLS_CACHE_HIT}"

du -hc external

if [[ "$TARGET_OS" == mac* || "$TARGET_OS" == iOS* || "$TARGET_OS" == android ]]; then
    FF_EXTRA=
fi
if [ `which dpkg` ]; then # TODO: multi arch
    #wget https://apt.llvm.org/llvm.sh
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key |sudo apt-key add -
    #sudo apt update
    #sudo apt install -y software-properties-common # for add-apt-repository, ubuntu-tooolchain-r-test is required by trusty
    sudo apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" # rpi
    sudo apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-11 main"
    sudo apt-add-repository "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main" # clang-12
    sudo apt update
    pkgs="sshpass cmake ninja-build p7zip-full lld-$LLVER clang-tools-$LLVER" # clang-tools: clang-cl
    if [ "$TARGET_OS" == "linux" ]; then
        pkgs+=" libc++-$LLVER-dev libc++abi-$LLVER-dev libegl1-mesa-dev libgles2-mesa-dev libgl1-mesa-dev libgbm-dev libx11-dev libwayland-dev libasound2-dev libopenal-dev libpulse-dev libva-dev libvdpau-dev libglfw3-dev libsdl2-dev"
    elif [ "$TARGET_OS" == "sunxi" -o "$TARGET_OS" == "raspberry-pi" ]; then
        pkgs+=" binutils-arm-linux-gnueabihf"
    fi
    sudo apt install -y $pkgs
elif [ `which brew` ]; then
    #time brew update --preinstall
    export HOMEBREW_NO_AUTO_UPDATE=1
    pkgs="p7zip ninja vulkan-headers" #
    if [[ "$DEVTOOLS_CACHE_HIT" != "true" ]]; then
        pkgs+=" hudochenkov/sshpass/sshpass"
    fi
    if [ "$TARGET_OS" == "macOS" ]; then
        pkgs+=" glfw3 sdl2"
        echo "$TARGET_ARCH" |grep arm >/dev/null || {
          time brew cask install xquartz
          pkgs+=" pulseaudio"
        }
    fi
    time brew install $pkgs
    NDK_HOST=darwin
fi

OS=${TARGET_OS/r*pi/rpi}
OS=${OS/*store/WinRT}
OS=${OS/*uwp*/WinRT}
OS=${OS%%-*}
OS=${OS/Simulator/}
[ "$TARGET_OS" == "linux" ] && OS=Linux
mkdir -p external/{bin,lib}/$OS

if [[ "$EXTERNAL_DEP_CACHE_HIT" != "true" ]]; then
  wget https://sourceforge.net/projects/avbuild/files/${TARGET_OS}/ffmpeg-${FF_VER}-${TARGET_OS}${FF_EXTRA}-lite${LTO_SUFFIX}.tar.xz/download -O ffmpeg-${TARGET_OS}.tar.xz
  tar Jxf ffmpeg-${TARGET_OS}.tar.xz
  #find ffmpeg-${FF_VER}-${TARGET_OS}${FF_EXTRA}-lite${LTO_SUFFIX}/lib -name "libav*.so*" -o  -name "libsw*.so*" -delete

  cp -af ffmpeg-${FF_VER}-${TARGET_OS}${FF_EXTRA}-lite${LTO_SUFFIX}/lib/* external/lib/$OS
  cp -af ffmpeg-${FF_VER}-${TARGET_OS}${FF_EXTRA}-lite${LTO_SUFFIX}/include external/
  cp -af ffmpeg-${FF_VER}-${TARGET_OS}${FF_EXTRA}-lite${LTO_SUFFIX}/bin/* external/bin/$OS # ffmpeg dll

  if [ "$TARGET_OS" == "sunxi" ]; then
      mkdir -p external/lib/sunxi/armv7
      cp -af ffmpeg-${FF_VER}-${TARGET_OS}${FF_EXTRA}-lite${LTO_SUFFIX}/lib/* external/lib/sunxi/armv7 #single arch package
  elif [ "$TARGET_OS" == "windows-desktop" ]; then
      wget https://github.com/glfw/glfw/releases/download/${GLFW_VER}/glfw-${GLFW_VER}.bin.WIN32.zip -O glfw32.zip
      wget https://github.com/glfw/glfw/releases/download/${GLFW_VER}/glfw-${GLFW_VER}.bin.WIN64.zip -O glfw64.zip
      7z x glfw32.zip
      7z x glfw64.zip
      cp -af glfw-${GLFW_VER}.bin.WIN32/include/GLFW external/include/
      cp -af glfw-${GLFW_VER}.bin.WIN64/include/GLFW external/include/
      cp glfw-${GLFW_VER}.bin.WIN32/lib-vc2019/glfw3.lib external/lib/windows/x86
      cp glfw-${GLFW_VER}.bin.WIN64/lib-vc2019/glfw3.lib external/lib/windows/x64
      # TODO: download in cmake(if check_include_files failed)
      wget https://github.com/KhronosGroup/Vulkan-Headers/archive/master.zip -O vk.zip
      7z x vk.zip
      cp -af Vulkan-Headers-master/include/vulkan external/include/
  fi

  if [[ "$TARGET_OS" == "win"* || "$TARGET_OS" == "uwp"* || "$TARGET_OS" == macOS ]]; then
    mkdir -p external/include/{EGL,GLES{2,3},KHR}
    for h in GLES2/gl2.h GLES2/gl2ext.h GLES2/gl2platform.h GLES3/gl3.h GLES3/gl3platform.h; do
      wget https://www.khronos.org/registry/OpenGL/api/${h} -O external/include/${h}
    done
    for h in EGL/egl.h EGL/eglext.h EGL/eglplatform.h KHR/khrplatform.h; do
      wget https://www.khronos.org/registry/EGL/api/${h} -O external/include/${h}
    done
  fi
fi

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

  if [ "$TARGET_OS" == "android" ]; then
    wget https://dl.google.com/android/repository/android-ndk-${NDK_VERSION:-r22}-${NDK_HOST}-x86_64.zip -O ndk.zip
    7z x ndk.zip -o/tmp &>/dev/null
    mv /tmp/android-ndk-${NDK_VERSION:-r22} ${ANDROID_NDK:-/tmp/android-ndk}
  fi
fi
