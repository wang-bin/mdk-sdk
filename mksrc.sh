
SRC_DIR=$1
INSTALL_DIR=$2

mkdir -p $INSTALL_DIR/src/{base,core,subtitle}
cp -avf ${SRC_DIR}/core/*.cpp $INSTALL_DIR/src/core
cp -avf ${SRC_DIR}/core/*.h $INSTALL_DIR/src/core
cp -avf ${SRC_DIR}/base/*.h* $INSTALL_DIR/src/base
cp -af ${SRC_DIR}/base/cppcompat $INSTALL_DIR/src/base
cp -avf ${SRC_DIR}/subtitle/SubtitleImageProducer.h $INSTALL_DIR/src/subtitle