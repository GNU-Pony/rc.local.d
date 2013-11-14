#!/bin/bash

# Configure the cursor to not blink, this is useful if your 
# cursor is blinking really fast.
# Suppressed with no-deallocate in the kernel command line

dv_do=1
for _w in $(cat "/proc/cmdline"); do
    if [ "${_w}" = "no-deallocate" ]; then
	dv_do=0
	break
    fi
done

if [ $dv_do = 1 ]; then
     deallocvt
fi

