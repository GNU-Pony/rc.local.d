#!/bin/bash

# Generate a unique machine identifier if missing
# Suppressed with no-machid in the kernel command line

 
mi_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-machid" ]; then
	mi_do=0
	break
    fi
done

if [ $mi_do = 1 ]; then
    if [ ! -f "£{ETC}/machine-id" ]; then
	uuidgen | tr -d - > "£{ETC}/machine-id"
    fi
fi

