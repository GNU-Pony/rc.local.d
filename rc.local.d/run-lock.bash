# -*- shell-script -*-

# Give members of the lock group write access to /run/lock
# Suppressed with no-run-lock in the kernel command line
 
rl_do=1
for _w in $(cat /proc/cmdline); do
    if [ "${_w}" = "no-run-lcok" ]; then
	rl_do=0
	break
    fi
done

if [ $rl_do = 1 ]; then
    chown root:lock /run/lock
    chmod g+w /run/lock
fi

