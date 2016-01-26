#!/bin/sh

FWD="/opt/etc/firewall.d"

export PATH=/opt/bin:/opt/sbin:/sbin:/usr/sbin:/bin:/usr/bin

start() {
	for prog in `ls $FWD`; do
	    $FWD/$prog
	done
}

FIREWALLD="/opt/etc/firewall.d"
whait_for_opt_mount() {
	logger "ext_firewall: waiting for opt to mount"
	COUNT=20
	while [ true ]; do
		if [ ! -d $FIREWALLD ]; then
			sleep 1
			COUNT=$((COUNT-1))
			if [ $COUNT = 0 ]; then
				logger "Waiting for $FIREWALLD failed. Exiting"
				exit 1
			fi
		else
			break
		fi
	done
}

whait_for_opt_mount
start
