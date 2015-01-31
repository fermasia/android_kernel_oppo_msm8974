#!/bin/bash
TOOLCHAIN="/home/nando/dev/toolchains/sabermodnew/bin"
CLEAN=$1
DEFCONF=$2
JOBS=$3

echo    # (optional) move to a new line
if [[ $CLEAN =~ ^[YySs]$ ]]
then
	make clean && make mrproper
	echo "CLEANING" 
fi

echo    # (optional) move to a new line
if [[ $DEFCONF =~ ^[YySs]$ ]]
then
	make ARCH=arm CROSS_COMPILE=$TOOLCHAIN/arm-eabi- msm8974_find7_defconfig
	

echo    # (optional) move to a new line
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN/arm-eabi- -j$JOBS
