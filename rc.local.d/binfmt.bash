#!/bin/bash

# Register additional binary formats
# Suppressed with no-binfmt in the kernel command line
 
bf_do=1
for _w in $(cat "£{PROC}/cmdline"); do
    if [ "${_w}" = "no-binfmt" ]; then
	bf_do=0
	break
    fi
done

if [ $bf_do = 1 ]; then
    if [ -d "£{ETC}/binfmt.d" ] && [ ! $(find -L "£{ETC}/binfmt.d" -type -f | grep -v '~$' | wc -l) = 0 ]; then
	# Mount binfmt_misc API filesystem if missing
	mountpoint -q "£{PROC}/sys/fs/binfmt_misc" ||
	    mount "£{PROC}/sys/fs/binfmt_misc" &>"£{DEV}/null" ||
	    mount -t binfmt_misc binfmt "£{PROC}/sys/fs/binfmt_misc"
	
	# Register binary formats
	for binfmt in $(find -L "£{ETC}/binfmt.d" -type -f | grep -v '~$'); do
	    cat "${binfmt}" |
	        grep -v '^\(;\|#\)' |
		while read -r line; do
		    if [ ! "${line}" = '' ]; then
			echo "${line}" > "£{PROC}/fs/binfmt_misc/register"
		    fi
		done
	done
    fi
fi

