#!/bin/bash
#
# usb2sys - find lsusb device in /sys file system
#

die()
{
    echo "$@"
    exit 1
}

[[ $# -lt 1 ]] && die "need vendor and product ids (from lsusb) as dddd:dddd"

vendor=${1%:*}
product=${1##*:}

sys=/sys/bus/usb/devices/
cd $sys

for d in *; do
    path=$sys$d
    if [ -f $path/idProduct ]; then
      prod=$( cat $path/idProduct )
      vend=$( cat $path/idVendor )

      if [ $prod = $product -a $vend = $vendor ]; then
        echo prod = $prod
        echo vend = $vend
        echo /sys device is $path
      fi
    fi
done
