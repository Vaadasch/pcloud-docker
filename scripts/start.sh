#!/bin/bash

if [ -z $PCLOUD_LOGIN ] ; then
        echo "Please provide account in PCLOUD_LOGIN variable"
        exit 0
fi

cmdargs=""
if [ -f /home/$USER/my_password.txt ] ; then
        pid=$(pcloudcc -u $PCLOUD_LOGIN -d -s -p < /home/$USER/my_password.txt | grep -Eo "[0-9]{2,}" | uniq)
else
        pid=$(pcloudcc -u $PCLOUD_LOGIN -d  | grep -Eo "[0-9]{2,}" | uniq)
fi

sleep 1

if [ -z "$pid" ] || ! ps -p $pid > /dev/null ; then
        echo "Unable to start pCloudCC"
        exit 0
fi

echo $pid > /home/pcloud/.pcloud/pid

