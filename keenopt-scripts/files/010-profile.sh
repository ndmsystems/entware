#!/bin/sh

[ -z "$user" ] && exit 0       # $user is undefined
if [ "$user" = "admin" ]; then
    home=/opt
else
    home=/opt/home
fi

if mkdir -p $home/$user; then
    chmod 0755 $home
    chmod 0700 $home/$user
    chown -R $user.$user $home/$user
    echo "$user's home directory created"
fi

profile=$home/$user/.profile

if [ ! -f $profile ]; then
    echo '#!/opt/bin/sh' > $profile
    echo '. /opt/etc/profile' >> $profile
    chmod +x $profile
    chown -R $user.$user $profile
    echo "$user's profile has been created"
fi
