#!/bin/bash

# Select a random SYSLINUX configuration for next boot
# Suppressed with no-syslinux-conf in the kernel command line

# Configurations are places in £{ETC}/syslinux-confs as directories
# that have a makefile. The makefile should, without arguments
# compile the configurations if necessary and, with the argument
# `install` it should apply the configurations


sc_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-syslinux-conf" ]; then
	sc_do=0
	break
    fi
done

if [ $sc_do = 1 ]; then
    sc_options=()
    for sc_dir in "£{ETC}/syslinux-confs"/*/; do
	if [ -x "${sc_dir}" ]; then
	    sc_options+=( "${sc_dir}" )
	fi
    done
    sc_dir=$(( ${RANDOM} % ${#sc_options[@]} ))
    sc_dir="${sc_options[${sc_dir}]}"
    cd "${sc_dir}" && make && make install
fi

