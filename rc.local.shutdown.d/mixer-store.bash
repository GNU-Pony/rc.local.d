#!/bin/bash

# Store the ALSA mixer settings
# Suppressed with no-mixer-store in the kernel command line

mx_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-mixer-store" ]; then
	mx_do=0
	break
    fi
done

if [ $mx_do = 1 ]; then
    alsactl store
fi

