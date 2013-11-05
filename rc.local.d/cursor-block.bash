#!/bin/bash

# Configure the cursor to be a full block by default.
# Suppressed with cursor-block in the kernel command line

cb_do=1
for _w in $(cat "/proc/cmdline"); do
    if [ "${_w}" = "cursor-block" ]; then
	cb_do=0
	break
    fi
done

if [ $cb_do = 1 ]; then
     echo 0 > "/sys/module/vt/parameters/cur_default"
     echo -e '\ec' ## clears the screen and sets the cursor
fi

