#!/bin/bash

# Configure Linux VT's default colour palette
# Suppressed with no-vt-colours in the kernel command line

# Configure the colours in /etc/vt-colours, this should
# contain three rows and 16 columns, the rows are the red,
# green and blue, respectively, value for each colour, and
# the columns, which are comma separated, are colours by
# index: black, red, green, yellow, blue, magenta, cyan,
# white, and then the same colours but when bold.
# The values are in decimal, you can create a file from
# the current settings by issue the command:
# 
#    cat /sys/module/vt/parameters/default_{red,grn,blu} > /etc/vt-colours


vc_do=1
for _w in $(cat "/proc/cmdline"); do
    if [ "${_w}" = "no-vt-colours" ]; then
	vc_do=0
	break
    fi
done

if [ $vc_do = 1 ]; then
     if [ -f "/etc/vt-colours" ]; then
	 setvtrgb "/etc/vt-colours"
     fi
fi

