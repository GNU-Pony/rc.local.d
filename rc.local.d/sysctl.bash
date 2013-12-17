#!/bin/bash

# Run sysctl to apply kernel configurations
# Suppressed with no-sysctl in the kernel command line
 
sc_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-sysctl" ]; then
	sc_do=0
	break
    fi
done

if [ $sc_do = 1 ]; then
    sysctl --system
fi

