#!/bin/bash

# Restore the system clock of the last session
# Suppressed with no-clock-restore in the kernel command line
# 
# This module is only intended for computers that do
# not have a hardware clock.

cl_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-clock-restore" ]; then
	cl_do=0
	break
    fi
done

if [ $cl_do = 1 ] && [ -f "£{VAR_LIB}/rc.local/clock" ]; then
    now=$(posixtime | cut -d . -f 1)
    last=$(cat "£{VAR_LIB}/rc.local/clock" | head -n 1)
    if (( $last > $now )); then
	date --set "$(cat "£{VAR_LIB}/rc.local/clock" | tail -n 1)"
    fi
fi

