#!/bin/sh

MOUNT="/opt"
INITD="$MOUNT/etc/init.d"
LOCKFILE="/var/lock/init_sh"
HOSTFILE="/etc/hosts"

export PATH=$MOUNT/bin:$MOUNT/sbin:/sbin:/usr/sbin:/bin:/usr/bin


whait_for_init_finish() {
	logger "Waiting for init to finish"
	COUNT=10
	while [ true ]; do
		if [ ! -f $HOSTFILE ]; then
			logger "Waiting for $HOSTFILE"
			sleep 1
			COUNT=$((COUNT-1))
			if [ $COUNT = 0 ]; then
				logger "Waiting for $HOSTFILE failed. Exiting"
				exit 1
			fi
		else
			break
		fi
	done 

	COUNT=15
	while [ true ]; do
		if [ -f $LOCKFILE ]; then
			logger "Waiting for $LOCKFILE to be removed"
			sleep 1
			COUNT=$((COUNT-1))
			if [ $COUNT = 0 ]; then
				logger "Waiting for $LOCKFILE failed. Exiting"
				exit 1
			fi
		else
			break
		fi
	done 
	# extra 2 seconds to sleep
	sleep 2
}

do_mount() {
	/bin/mount -o bind "/media/DISK_A1/opt" /opt
	if [ $? -ne 0 ] ; then
		logger "Mount /media/DISK_A1/opt to /opt FAILED! WTF?"
		exit 1
	fi
}

do_umount() {
	/bin/umount /opt
}


if [ -f $LOCKFILE ]; then
	logger "$LOCKFILE exists"
fi
if [ ! -f $HOSTFILE ]; then
	logger "$HOSTFILE does not exist"
fi

case "$1" in
	start)
		whait_for_init_finish
		do_mount		
		/opt/etc/init.d/rc.unslung start
		;;
	stop)
		/opt/etc/init.d/rc.unslung stop
		sleep 1
		do_umount
		;;
	restart)
# Do nothing wait for /bin/init.sh	to finish. All initialization is done from mount script
		;;
	link_up)
		;;
	ppp_up)
		;;
	link_down)
		;;
	ppp_down)
		;;
	*)
		echo "Usage: $0 {start|stop|restart|link_up|link_down|ppp_up|ppp_down}"
		;;
esac
