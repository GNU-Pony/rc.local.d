#!/bin/bash

# Store the system clock so it can be restored to at next boot
# Suppressed with no-clock-store in the kernel command line
# 
# This module is only intended for computers that do
# not have a hardware clock.

cl_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-clock-store" ]; then
	cl_do=0
	break
    fi
done

if [ $cl_do = 1 ]; then
    if [ -f "£{VAR_LIB}/rc.local/clock" ]; then
	now=$(posixtime | cut -d . -f 1)
	last=$(cat "£{VAR_LIB}/rc.local/clock" | head -n 1)
	if (( $now > $last )); then
	    echo $now > "£{VAR_LIB}/rc.local/clock"
	    date --rfc-3339=ns >> "£{VAR_LIB}/rc.local/clock"
	fi
    else
	mkdir -p "£{VAR_LIB}/rc.local"
	posixtime | cut -d . -f 1 > "£{VAR_LIB}/rc.local/clock"
	date --rfc-3339=ns >> "£{VAR_LIB}/rc.local/clock"
    fi
fi

