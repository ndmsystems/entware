#!/opt/bin/sh

while [ -z "$(pidof dropbear)" ] ; do
    sleep 1
    echo '.'
done
rm $0
