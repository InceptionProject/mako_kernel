#!/sbin/sh
mkdir /tmp/ramdisk
cd /tmp/ramdisk
gunzip -c ../boot.img-ramdisk.gz | cpio -i
sed -i '/mpdecision/{n; /class main$/d}' init.mako.rc
sed -i '/thermald/{n; /class main$/d}' init.mako.rc
sed -i '/mpdecision/d' init.mako.rc
sed -i '/thermald/d' init.mako.rc
sed -i '/scaling_min_freq/d' init.mako.rc
sed -i '/sampling_rate/d' init.mako.rc
sed -i '/up_threshold/d' init.mako.rc
sed -i '/sampling_down_factor/d' init.mako.rc
sed -i '/scaling_governor/d' init.mako.rc
find . | cpio -o -H newc | gzip > ../newramdisk.cpio.gz
cd /
