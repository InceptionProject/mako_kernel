#!/bin/bash
#
#  Inception
#

rm arch/arm/boot/zImage
rm kernel.log
rm any-kernel/kernel/zImage
rm any-kernel/Inception.kernel-nightly.zip

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
echo "Inception"
cp arch/arm/boot/zImage any-kernel/kernel

zipfile="Inception.kernel-nightly.zip"
echo ""
echo "zipping kernel"

cd any-kernel/
rm -f *.zip
zip -r -9 $zipfile *
rm -f /tmp/*.zip
cp *.zip /tmp

cp any-kernel/Inception.kernel-nightly.zip ../Flash

rm arch/arm/boot/zImage
rm kernel.log
rm any-kernel/kernel/zImage
rm any-kernel/Inception.kernel-nightly.zip

echo ""
echo ""
echo "Kernel build done"
echo ""
echo ""
