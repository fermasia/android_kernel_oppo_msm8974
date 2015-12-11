#!/bin/bash
TOOLCHAIN="/home/nando/dev/toolchains/linaro49a15/bin"
JOBS="-j$(grep -c ^processor /proc/cpuinfo)"
echo "Cleaning old files"
rm -f ../AnykernelOMNI/dtb
rm -f ../AnykernelOMNI/zImage
echo "Making kernel"
DATE_START=$(date +"%s")

make clean && make mrproper

export ARCH=arm
export SUBARCH=arm
make CROSS_COMPILE=$TOOLCHAIN/arm-cortex_a15-linux-gnueabihf- msm8974_find7op_defconfig
make CROSS_COMPILE=$TOOLCHAIN/arm-cortex_a15-linux-gnueabihf- $JOBS
echo "End of compiling kernel!"

DATE_END=$(date +"%s")
echo
DIFF=$(($DATE_END - $DATE_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."

../ramdisk_one_plus_one/dtbToolCM -2 -o ../AnykernelOMNI/dtb -s 2048 -p ../omni/scripts/dtc/ ../omni/arch/arm/boot/
cp arch/arm/boot/zImage ../AnykernelOMNI/zImage
cd ../AnykernelOMNI/
zipfile="DONKEY-V"$1".zip"
zip -r -9 $zipfile *
mv DONKEY-V*.zip ../OUT/
