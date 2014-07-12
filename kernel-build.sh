#!/bin/bash
#
#  Inception
#

rm arch/arm/boot/zImage
rm boot.img
rm kernel.log
rm zip/boot.img
rm zip/Inception.kernel-nightly.zip

clear

echo ""
echo ""
echo "Start kernel build"
echo ""
echo ""

git checkout kk

make clean
make mrproper
export ARCH=arm
export CROSS_COMPILE=~/toolchain/arm-eabi-4.10/bin/arm-eabi-
export ENABLE_GRAPHITE=true
make inception_defconfig
time make -j6 2>&1 | tee kernel.log

echo ""
echo "Building boot.img"
cp arch/arm/boot/zImage ../ramdisk_mako/

cd ../ramdisk_mako/

echo ""
echo "building ramdisk"
./mkbootfs ramdisk | gzip > ramdisk.gz
echo ""
echo "making boot image"
./mkbootimg --kernel zImage --cmdline 'console=ttyHSL0,115200,n8 androidboot.hardware=mako lpj=67677 user_debug=31' --base 0x80200000 --pagesize 2048 --ramdisk_offset 0x01600000 --ramdisk ramdisk.gz --output ../mako/boot.img

rm -rf ramdisk.gz
rm -rf zImage

cd ../mako/

zipfile="Inception.kernel-nightly.zip"
echo ""
echo "zipping kernel"
cp boot.img zip/

rm -rf ../ramdisk_mako/boot.img

cd zip/
rm -f *.zip
zip -r -9 $zipfile *
rm -f /tmp/*.zip
cp *.zip /tmp

cd ..
rm arch/arm/boot/zImage
rm boot.img
rm kernel.log
rm zip/boot.img

echo ""
echo ""
echo "Kernel build done"
echo ""
echo ""
