#!/bin/bash

dt=$(date -Iminutes | awk -F '+' '{print $1}' | sed 's#T#_#')

[ -z "$BACKUP_DIR" ] && BACKUP_DIR="Automated_saves"

for file in /data/* ; do
        name=${file##*/}
        mkdir -p /pdrive/$BACKUP_DIR/$name
        tar -zcf /pdrive/$BACKUP_DIR/$name/${name}_${dt}.tar /data/$name
        rm -rf /data/$name
done

