#!/bin/bash

../ramdisk_opo_omni/dtbToolCM -2 -o ../ramdisk_opo_omni/split_img/boot.img-dtb -s 2048 -p ../kernel_opo_omni/scripts/dtc/ ../kernel_opo_omni/arch/arm/boot/
cp arch/arm/boot/zImage ../ramdisk_opo_omni/split_img/boot.img-zImage

cd ../ramdisk_opo_omni/

./repackimg.sh

cd ../kernel_opo_omni/

zipfile="OmniKernel-"$1".zip"
echo "making zip file"
cp ../ramdisk_opo_omni/image-new.img zip/boot.img
cd zip/
rm -f *.zip
zip -r -9 $zipfile *
rm -f /tmp/*.zip
cp *.zip /tmp
cp *.zip /home/nando/dev/OUT
rm -f *.zip
rm -f boot.img
