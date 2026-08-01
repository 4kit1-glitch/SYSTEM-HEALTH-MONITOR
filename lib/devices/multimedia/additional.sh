#!/usr/bin/env bash

# this script processes additional connected devices
# camera
# usb -connected
# remote devices
#get_additional_device_info
#
#
#
#
#
#
#

declare -r usd_divices_count=$(lsusb | wc -l)
declare -r camera_names=$(
    lsusb | grep -i "camera" | awk '{for(i=7;i<=NF;i++) printf "%s ", $i}'
)
declare -r all_extra=$(
    lsusb | awk '{for(i=7;i<=NF;i++) printf "%s ", $i} {printf "\n"}'
)

get_additional_device_info() {
    printf "%s\n" "$camera_names"  
}
