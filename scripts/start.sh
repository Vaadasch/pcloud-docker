#!/bin/bash

if [ -z $PCLOUD_LOGIN ] ; then
        echo "Please provide account in PCLOUD_LOGIN variable"
        exit 0
fi

if [ -f /my_password.txt ] ; then
        echo "Connection using the password"
        pcloudcc -u $PCLOUD_LOGIN -s -p < /my_password.txt &
else
        echo "Connection without password"
        pcloudcc -u $PCLOUD_LOGIN &
fi

echo "Waiting 20 secondes to pCloud to scan and check if fusermount is here"
sleep 20

if ! pgrep -x "fusermount" > /dev/null ; then
        echo "Unable to start pCloudCC"
        exit 0
fi

while [ 1 ] ; do
        sleep 2
        /bin/bash /script.sh
done

