#!/bin/sh

export PATH=/opt/sbin:/opt/bin:$PATH

URL=http://ndm.zyxmon.org/binaries/keenetic/installer/

echo "Entware-ng installation started"

# check /opt already mounted
grep -q /opt /proc/mounts && echo "/opt already mounted" &&  exit 0

# make dir "opt" on the drive root
mkdir -p /media/DISK_A1/opt
[ ! -d "/media/DISK_A1/opt" ] && echo "cannot create /opt folder on hdd" && exit 0

# mount /opt (bind only)
mount -o bind "/media/DISK_A1/opt" /opt
if [ $? -ne 0 ] ; then
	echo "Mount /media/DISK_A1/opt to /opt FAILED! WTF?"
	exit 1
fi

echo "Info: Creating folders..."
for folder in bin etc/init.d etc/firewall.d lib/opkg lib/modules/current sbin share tmp usr var/log var/lock var/run
do
    if [ -d "/opt/$folder" ]
    then
	echo "Warning: Folder /opt/$folder exists! If something goes wrong please clean /opt folder and try again."
    else
	mkdir -p /opt/$folder
    fi
done

# full access for /opt/tmp & /var/lock may be needed in multiuser environment
chmod 777 "/opt/tmp"
chmod 777 "/opt/var/lock"

dl () {
# $1 - URL to download
# $2 - place to store
# $3 - 'x' if should be executable
    echo -n "Downloading $2... "
    wget -q $1 -O $2
    if [ $? -eq 0 ] ; then
	echo "success!"
    else
	echo "failed!"
	exit 1
    fi
    [ -z "$3" ] || chmod +x $2
}

echo "Info: Deploying opkg package manager..."
dl $URL/opkg /opt/bin/opkg x
dl $URL/opkg.conf /opt/etc/opkg.conf

echo "Info: Basic packages installation..."

opkg update
opkg install opt-ndmsv1
opkg install busybox-zyx
opkg install dropbear

mkdir -p /opt/etc/dropbear/authorized_keys
chmod 600 /opt/etc/dropbear/authorized_keys

mkdir -p /media/DISK_A1/system/bin
dl $URL/ext_init.sh /media/DISK_A1/system/bin/ext_init.sh x
dl $URL/ext_firewall.sh /media/DISK_A1/system/bin/ext_firewall.sh x

SWAPFILE="/opt/.swapfile"
echo "Creating swap file. Please wait..."
dd if=/dev/zero of=$SWAPFILE bs=1048576 count=128
sync
mkswap $SWAPFILE 2> /dev/null

echo "Starting Entware ...."
/opt/etc/init.d/rc.unslung start

cat << EOF

Поздравляем! Если скрипт не выдал ошибок, то сиcтема пакетов Entware-ng успешно установлена.

Нашли ошибку - сообщите на форуме http://forums.zyxmon.org/viewforum.php?f=5

Для установки пакетов используйте команду 'opkg install <pkg_name>'.

Если Вам не нужен своп файл, переименуйте /opt/etc/init.d/S01swap в /opt/etc/init.d/K01swap.

EOF
