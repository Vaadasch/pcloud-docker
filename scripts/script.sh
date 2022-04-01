#!/bin/bash

dt=$(date +%F_%Hh%M)

[ -z "$BACKUP_DIR" ] && BACKUP_DIR="Automated_saves"

#for file in /data/* ; do
find /data -maxdepth 1 -mindepth 1 -print0 | while IFS= read -r -d '' file; do
        [ -e "$file" ] || continue
        name=${file##*/}
        [ -z "$name" ] && continue
        mkdir -p "/pdrive/$BACKUP_DIR/$name"
        tar -zcf "/pdrive/$BACKUP_DIR/$name/${name}_${dt}.tar.gz" "$file"
        rm -rf "$file"
done

