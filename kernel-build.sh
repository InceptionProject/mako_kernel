#!/bin/bash
#
#  Inception
#

clear

echo ""
echo ""
echo "Started Hacking Your Dreams"
echo ""
echo ""

git checkout kk

make clean
make mrproper
export PATH=$PATH:~/toolchain/arm-eabi-4.10/bin
export ARCH=arm
export CROSS_COMPILE=arm-eabi-
export ENABLE_GRAPHITE=true
make inception_defconfig
make -j6

echo ""
echo ""
echo "Your Dreams Are Hacked"
echo ""
echo ""

cp arch/arm/boot/zImage ../ramdisk_mako/
 
cd ../ramdisk_mako/
 
echo "making ramdisk"
./mkbootfs boot.img-ramdisk | gzip > ramdisk.gz
echo "making boot image"
./mkbootimg --kernel zImage --cmdline 'console=ttyHSL0,115200,n8 androidboot.hardware=mako lpj=67677 user_debug=31' --base 0x80200000 --pagesize 2048 --ramdisk_offset 0x01600000 --ramdisk ramdisk.gz --output ../mako/boot.img
 
rm -rf ramdisk.gz
rm -rf zImage
 
cd ../mako/
 
zipfile="Inception.Kernel-nightly.zip"
echo "making zip file"
cp boot.img zip/
 
rm -rf ../ramdisk_mako/boot.img
 
cd zip/
rm -f *.zip
zip -r $zipfile *
rm -f /tmp/*.zip
cp *.zip /tmp
