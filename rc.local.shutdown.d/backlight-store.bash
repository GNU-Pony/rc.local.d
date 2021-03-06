#!/bin/bash

# Store the backlight of the last session
# Suppressed with no-backlight-store in the kernel command line

bl_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-backlight-store" ]; then
	bl_do=0
	break
    fi
done

if [ $bl_do = 1 ]; then
    if [ ! -d "£{VAR_LIB}/rc.local/backlight" ]; then
	mkdir -p "£{VAR_LIB}/rc.local/backlight"
    fi
    for bl_device in $(ls -1 "£{SYS}/class/backlight/"); do
	bl_lib="£{VAR_LIB}/rc.local/backlight/${bl_device}"
	bl_device="£{SYS}/class/backlight/${bl_device}"
	if [ -f "${bl_device}/max_brightness" ] && [ -f "${bl_device}/brightness" ]; then
	    cat "${bl_device}/brightness" > "${bl_lib}"
	fi
    done
fi

