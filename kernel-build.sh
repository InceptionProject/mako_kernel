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


