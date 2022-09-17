#!/bin/bash
SDK_DIR=$1
ARCH=$2
SDK_DIR_OUT=$SDK_DIR
[ -n "$ARCH" ] && SDK_DIR_OUT=mdk-sdk
mkdir -p $SDK_DIR_OUT

mkdir -p $SDK_DIR/include # for apple
SDK_INCLUDE=$SDK_DIR/include/mdk
TMP=`mktemp -d`
# TODO: cmake files for different arch
tar cf $TMP/cmake.tar $SDK_DIR/lib/cmake/FindMDK.cmake
if [ -d $SDK_DIR/lib/mdk.framework ]; then
  tar cf $TMP/h.tar $SDK_DIR/lib/mdk.framework
  rm -rf $SDK_DIR/lib/*
  tar xf $TMP/h.tar
  ln -sf lib $SDK_DIR/Frameworks
  [ -d $SDK_INCLUDE ] && rm -rf $SDK_INCLUDE
  [ -L $SDK_INCLUDE ] && rm -f $SDK_INCLUDE
  ln -sfv ../lib/mdk.framework/Headers $SDK_INCLUDE #gln -rsfv $SDK_DIR/lib/mdk.framework/Headers $SDK_INCLUDE
  mv $SDK_DIR/lib/mdk.framework/Versions/Current/mdk.dSYM $SDK_DIR/lib/mdk.framework.dSYM
  rm -rf $SDK_DIR/lib/mdk.framework/mdk.dSYM # iOS
  ffdso=(`find $SDK_DIR/lib/mdk.framework -name "libffmpeg.*.dylib"`)
  ffdso=${ffdso[$((${#ffdso[@]}-1))]}
  ffdso=${ffdso##*lib/}
  [ -n "$ffdso" ] && ln -sf $ffdso $SDK_DIR/lib/
else
  tar cf $TMP/h.tar $SDK_DIR/include/mdk
  rm -rf $SDK_DIR/include/*
  tar xf $TMP/h.tar
  if [ -L "$SDK_DIR/lib/libmdk.so" ]; then # on macOS, a symlink is not a regular file, on linux it is
    cp -afv $SDK_DIR/lib/libmdk.so $TMP/
    cp -afvL $SDK_DIR/lib/libmdk-*.so $TMP/
    cp -afvL $SDK_DIR/lib/libmdk*.dsym $TMP/
    cp -afvL $SDK_DIR/lib/lib{ffmpeg,mdk}.so.? $TMP/
    cp -afvL $SDK_DIR/lib/libc++.so.1 $TMP/
  elif [ -f "$SDK_DIR/lib/libmdk.so" ]; then # android
    cp -afvL $SDK_DIR/lib/lib{ffmpeg,mdk-*}.so $TMP/
    cp -afvL $SDK_DIR/lib/libmdk.so $TMP/
    cp -afvL $SDK_DIR/lib/libmdk.so.dsym $TMP/
  elif [ -f "$SDK_DIR/lib/mdk.lib" ]; then
    cp -afvL $SDK_DIR/lib/mdk.lib $TMP/
    cp -afvL $SDK_DIR/bin/{ffmpeg,mdk}*.dll $TMP/
    cp -afvL $SDK_DIR/bin/mdk*.pdb $TMP/
  elif [ -f "$SDK_DIR/lib/libmdk.dll.a" ]; then
    cp -afvL $SDK_DIR/lib/libmdk.dll.a $TMP/
    cp -afvL $SDK_DIR/bin/lib{ffmpeg,mdk}*.dll $TMP/
  fi
  rm -rfv $SDK_DIR/lib/* $SDK_DIR/bin/*.{dll,pdb} # clean up unneeded files

  mkdir -p $SDK_DIR_OUT/bin/$ARCH
  mv $TMP/*mdk*.{dll,pdb} $TMP/*ffmpeg-?.dll $SDK_DIR_OUT/bin/$ARCH

  mkdir -p $SDK_DIR_OUT/lib/$ARCH
  mv -v $TMP/libmdk* $TMP/mdk.lib $TMP/libffmpeg.so* $TMP/libc++.so.1 $SDK_DIR_OUT/lib/$ARCH
fi
tar xf $TMP/cmake.tar

if [ -d "$SDK_INCLUDE/cpp" ]; then
  rm -rf $SDK_INCLUDE/*.h
  hs=(`find "$SDK_INCLUDE/cpp" -name "*.h"`)
  for h in ${hs[@]}; do
    echo $h
    sed '/#include /s/\.\.\/c\//c\//g' $h > $SDK_INCLUDE/${h##*/}
  done
  rm -rf "$SDK_INCLUDE/cpp"
fi

[ -n "$ARCH" ] && {
  cp -anvf $SDK_DIR/include $SDK_DIR_OUT
  cp -anvf $SDK_DIR/build $SDK_DIR_OUT # for win
  cp -anvf $SDK_DIR/doc $SDK_DIR_OUT
  cp -nvf $SDK_DIR/* $SDK_DIR_OUT
  mkdir -p $SDK_DIR_OUT/lib/cmake/
  cp -anvf $SDK_DIR/lib/cmake/FindMDK.cmake $SDK_DIR_OUT/lib/cmake/
  BIN_DIR_OUT=$SDK_DIR_OUT/bin/$ARCH
  mkdir -p $BIN_DIR_OUT
  cp -nvf $SDK_DIR/bin/* $BIN_DIR_OUT
}
rm -rf $TMP