#!/bin/sh

# Working dir should stay in feeds/keenopt4entware
SCRIPT_DIR=$(dirname $0)
ROOT_DIR=$SCRIPT_DIR/installer_root
BUILD_DIR=$SCRIPT_DIR/../../build_dir/target-mipsel_mips32r2_uClibc-*
INSTALLER=$SCRIPT_DIR/installer-entware.tar.gz

[ -d $ROOT_DIR ] && rm -fr $ROOT_DIR
mkdir $ROOT_DIR

# Adding toolchain libraries
cp -r $BUILD_DIR/toolchain/ipkg-mipselsf/libc/opt $ROOT_DIR

# Adding busybox
cp -r $BUILD_DIR/busybox-*/ipkg-install/opt $ROOT_DIR

# Adding install script
mkdir $ROOT_DIR/opt/etc
cp $SCRIPT_DIR/initrc $ROOT_DIR/opt/etc

# Packing installer
[ -f $INSTALLER ] && rm $INSTALLER
tar -czf $INSTALLER -C $ROOT_DIR/opt bin lib sbin
rm -fr $ROOT_DIR
