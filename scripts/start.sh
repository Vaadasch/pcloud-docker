#!/bin/bash

if [ -z $PCLOUD_LOGIN ] ; then
        echo "Please provide account in PCLOUD_LOGIN variable"
        exit 0
fi

if [ -f /home/$USER/my_password.txt ] ; then
        pcloudcc -u $PCLOUD_LOGIN -s -p < /home/$USER/my_password.txt &
else
        pcloudcc -u $PCLOUD_LOGIN &
fi

sleep 1

if [ $(ps aux | grep pCloudDr | grep -v grep | wc -l) != 2 ] ; then
        echo "Unable to start pCloudCC"
        exit 0
fi

while [ 1 ] ; do
        sleep 2
        /bin/bash /home/pcloud/script.sh
done

