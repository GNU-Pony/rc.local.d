#!/bin/bash

# Uses the Network Time Protocol via `ntpdate` to syncronise clock
# Suppressed with no-ntpdate in the kernel command line

 
nd_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-ntpdate" ]; then
	nd_do=0
	break
    fi
done

if [ $nd_do = 1 ]; then
    if [ -z "${NTPDATE_SERVER}" ]; then
	. "£{PROC}/rc.conf"
	if [ -z "${NTPDATE_SERVER}" ]; then
	    NTPDATE_SERVER="time.nist.gov"
	fi
    fi
    ntpdate -s "${NTPDATE_SERVER}"
fi

