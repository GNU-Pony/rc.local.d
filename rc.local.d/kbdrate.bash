#!/bin/bash

# Set the keyboard repeat delay and rate
# Suppressed with no-kbdrate in the kernel command line

 
kr_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-kbdrate" ]; then
	kr_do=0
	break
    fi
done

if [ $kr_do = 1 ]; then
    . "£{ETC}/rc.conf"
    if [ -n "${KEYBOARD_RATE}" ]; then
	rate=( ${KEYBOARD_RATE/./ } )
	set rate
	opts=()
	if [ -n "$1" ]; then
	    opts+=( -d "$1" )
	fi
	if [ -n "$2" ]; then
	    opts+=( -r "$2" )
	fi
	if [ ! ${#opts[@]} = 0 ]; then
	    kbdrate "${opts[@]}"
	fi
    fi
fi

