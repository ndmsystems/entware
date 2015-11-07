#!/bin/sh

if ! grep -q '^root:' /tmp/passwd; then
    echo 'root:*:0:0:ZyXEL Keenetic, user "root":/opt/root/:/bin/sh' >> /tmp/passwd
    echo "Default record for root is added to /tmp/passwd"
fi

current_pwd=$(grep ^root /tmp/passwd | cut -d : -f 2)
saved_pwd=$(cat /opt/etc/passwd.root)

if [ "$current_pwd" == "$saved_pwd" ]; then
    echo "Pasword is not changed"
    exit 0
fi

if [ "$current_pwd" == "*" ]; then
    sed -i "s|^root:\*|root:$saved_pwd|" /tmp/passwd
    echo "Pasword is set from file"
    exit 0
fi

if [ "$current_pwd" != "$saved_pwd" ]; then
    echo "$current_pwd" > /opt/etc/passwd.root
    echo "New password is saved to file"
    exit 0
fi
