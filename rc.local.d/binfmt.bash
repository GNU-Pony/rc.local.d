# -*- shell-script -*-

# Register additional binary formats
# Suppressed with no-binfmt in the kernel command line
 
bf_do=1
for _w in $(cat /proc/cmdline); do
    if [ "${_w}" = "no-binfmt" ]; then
	bf_do=0
	break
    fi
done

if [ $bf_do = 1 ]; then
    if [ -d /etc/binfmt.d ] && [ ! $(find -L /etc/binfmt.d -type -f | grep -v '~$' | wc -l) = 0 ]; then
	# Mount binfmt_misc API filesystem if missing
	mountpoint -q /proc/sys/fs/binfmt_misc ||
	    mount /proc/sys/fs/binfmt_misc &>/dev/null ||
	    mount -t binfmt_misc binfmt /proc/sys/fs/binfmt_misc
	
	# Register binary formats
	for binfmt in $(find -L /etc/binfmt.d -type -f | grep -v '~$'); do
	    while read -r line; do
		if [ ! ${line:0:1} = '#' ]; then
		    echo "${line}" > /proc/fs/binfmt_misc/register
		fi
	    done < "${binfmt}"
	done
    fi
fi

