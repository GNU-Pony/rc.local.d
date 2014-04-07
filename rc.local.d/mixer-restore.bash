#!/bin/bash

# Restore the ALSA mixer settings of the last or a saved session
# Suppressed with no-mixer-restore in the kernel command line

mx_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-mixer-restore" ]; then
	mx_do=0
	break
    fi
done

if [ $mx_do = 1 ]; then
    alsactl restore
fi

