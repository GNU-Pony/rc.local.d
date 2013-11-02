#!/bin/bash

# Give members of the lock group write access to £{RUN_LOCK}
# Suppressed with no-run-lock in the kernel command line
 
rl_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-run-lock" ]; then
	rl_do=0
	break
    fi
done

if [ $rl_do = 1 ]; then
    chown root:lock "£{RUN_LOCK}"
    chmod g+w "£{RUN_LOCK}"
fi

