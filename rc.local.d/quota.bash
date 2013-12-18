#!/bin/bash

# Check and apply filesystem quotas
# Checking suppressed with no-quotacheck in the kernel command line
# Applying suppressed with no-quota in the kernel command line

 
qo_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-quota" ]; then
	qo_do=0
	break
    fi
done
 
qc_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-quotacheck" ]; then
	qc_do=0
	break
    fi
done

if [ $qc_do = 1 ]; then
    quotacheck --all
fi

if [ $qo_do = 1 ]; then
    quotaon --all
fi


