# -*- shell-script -*-

# Restore the backlight of the last session
# Suppressed with no-backlight-restore in the kernel command line

bl_do=1
for _w in $(cat /proc/cmdline); do
    if [ "${_w}" = "no-backlight-restore" ]; then
	bl_do=0
	break
    fi
done

if [ $bl_do = 1 ] && [ -d /var/lib/rc.local/backlight ]; then
    for bl_device in $(ls -1 /sys/class/backlight/); do
	bl_lib="/var/lib/rc.local/backlight/${bl_device}"
	bl_device="/sys/class/backlight/${bl_device}"
	if [ -f "${bl_device}/max_brightness" ] && [ -f "${bl_device}/brightness" ] && [ -f "${bl_lib}" ]; then
	    cat "${bl_lib}" > "${bl_device}/brightness"
	fi
    done
fi

