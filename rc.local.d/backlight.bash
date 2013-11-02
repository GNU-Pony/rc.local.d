#!/bin/bash

# Set backlight to 50 % on all devices
# Suppressed with no-backlight in the kernel command line
 
bl_do=1
for _w in $(cat /proc/cmdline); do
    if [ "${_w}" = "no-backlight" ]; then
	bl_do=0
	break
    fi
done

if [ $bl_do = 1 ]; then
    for bl_device in $(ls -1 /sys/class/backlight/); do
	bl_device="/sys/class/backlight/${bl_device}"
	if [ -f "${bl_device}/max_brightness" ] && [ -f "${bl_device}/brightness" ]; then
	    bl_max=$(cat "${bl_device}/max_brightness")
	    echo $(( (${bl_max} + 1) / 2 )) > "${bl_device}/brightness"
	fi
    done
fi

