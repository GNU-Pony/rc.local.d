#!/bin/bash

# Configure the cursor to not blink, this is useful if your 
# cursor is blinking really fast.
# Suppressed with cursor-blink in the kernel command line

cb_do=1
for _w in $(cat "/proc/cmdline"); do
    if [ "${_w}" = "cursor-blink" ]; then
	cb_do=0
	break
    fi
done

if [ $cb_do = 1 ]; then
     echo 0 > "/sys/devices/virtual/graphics/fbcon/cursor_blink"
fi

