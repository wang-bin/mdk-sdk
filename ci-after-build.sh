ls -lh build/${TARGET_OS}*
if [ -f build/${TARGET_OS}/libmdk.so ]; then
  readelf -d build/${TARGET_OS}/libmdk.so
fi
if [ -f build/${TARGET_OS}/cmake_install.cmake ]; then
  cmake -P build/${TARGET_OS}/cmake_install.cmake
  tools/mksdk.sh mdk-sdk || echo done
fi
if [ -f mdk-sdk/lib/mdk.framework/mdk ]; then
  otool -l mdk-sdk/lib/mdk.framework/mdk
  otool -L mdk-sdk/lib/mdk.framework/mdk
  echo codesign
  codesign --force  --sign - --deep --timestamp mdk-sdk/lib/mdk.framework
fi
for s in build/${TARGET_OS}-*; do
  echo "sdk: $s"
  a=${s/*${TARGET_OS}-/}
  echo "arch: $a"
  if [ -f build/${TARGET_OS}-$a/cmake_install.cmake ]; then
    cmake -P build/${TARGET_OS}-$a/cmake_install.cmake
    tools/mksdk.sh mdk-sdk-$a $a || echo done # FIXME: android arch
  fi
done
find mdk-sdk* -name "*.a" -delete

echo stripping
export PATH=$PATH:$ANDROID_NDK_LATEST_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin:$ANDROID_NDK_LATEST_HOME/toolchains/llvm/prebuilt/darwin-x86_64/bin:$OHOS_NDK/llvm/bin
: ${STRIP:=llvm-strip-$LLVM_VER}
which $STRIP || STRIP=llvm-strip
[ "$TARGET_OS" == "macOS" ] && STRIP=strip && STRIP_ARGS="-u -r"
ls -lh mdk-sdk*/bin/*
which $STRIP && find mdk-sdk*/bin -type f -exec $STRIP $STRIP_ARGS {} \;
ls -lh mdk-sdk*/bin/*
export XZ_OPT="-T0" # -9e. -8/9 will disable mt?
if [[ "$TARGET_OS" == "win"* || "$TARGET_OS" == "uwp"* || "$TARGET_OS" == "android" || "$TARGET_OS" == ohos ]]; then
  7z a -ssc -m0=lzma2 -mx=9 -ms=on -mf=off mdk-sdk-${TARGET_OS}.7z mdk-sdk
  ls -lh mdk-sdk-${TARGET_OS}.7z
else
  TAR=tar
# brew install gnu-tar. gtar result is 1/3 much smaller, but 1/2 slower, also no hidden files(GNUSparseFile.0). T0 is 2x faster than bsdtar
  which gtar && TAR=gtar
  $TAR Jcvf mdk-sdk-${TARGET_OS}.tar.xz mdk-sdk
  ls -lh mdk-sdk-${TARGET_OS}.tar.xz
fi
#if [ `which sshpass` ]; then
  #echo sshpass -p "$SF_PW" scp -o StrictHostKeyChecking=no mdk-sdk-${TARGET_OS}.tar.xz $SF_USER@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
  #sshpass -e scp -o StrictHostKeyChecking=no mdk-sdk-${TARGET_OS}.tar.xz $SF_USER@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
  #sshpass -e scp -o StrictHostKeyChecking=no mdk-sdk-${TARGET_OS}.tar.xz $SF_USER@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
  #echo $?
#fi