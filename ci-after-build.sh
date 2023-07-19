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
: ${STRIP:=llvm-strip}
[ "$TARGET_OS" == "macOS" ] && STRIP=strip
which $STRIP && find mdk-sdk*/bin -executable -type f -exec $STRIP {} \;
export XZ_OPT="--threads=`getconf _NPROCESSORS_ONLN`" # -9e. -8/9 will disable mt?
if [[ "$TARGET_OS" == "win"* || "$TARGET_OS" == "uwp"* || "$TARGET_OS" == "android" ]]; then
  7z a -ssc -m0=lzma2 -mx=9 -ms=on -mf=off mdk-sdk-${TARGET_OS}.7z mdk-sdk
  ls -lh mdk-sdk-${TARGET_OS}.7z
else
  tar Jcvf mdk-sdk-${TARGET_OS}.tar.xz mdk-sdk
  ls -lh mdk-sdk-${TARGET_OS}.tar.xz
fi
#if [ `which sshpass` ]; then
  #echo sshpass -p "$SF_PW" scp -o StrictHostKeyChecking=no mdk-sdk-${TARGET_OS}.tar.xz $SF_USER@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
  #sshpass -e scp -o StrictHostKeyChecking=no mdk-sdk-${TARGET_OS}.tar.xz $SF_USER@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
  #sshpass -e scp -o StrictHostKeyChecking=no mdk-sdk-${TARGET_OS}.tar.xz $SF_USER@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
  #echo $?
#fi