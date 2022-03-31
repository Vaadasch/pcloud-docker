# pcloud-docker

## Warnings : 
Never expose services from this container as it needs to have the `--privileged` flag or `CAP_SYS_ADMIN`. 

## Usage

Define what you want to do with this container with the script.sh binded to `/home/pcloud/script.sh`. You'll probably want to send files to pCloud, you can map a shared volume at /data or anywhere else, only the script.sh will be using it anyway.

See `compose.yml` :

```
services:
  pcloud : 
    image: pcloud-docker
    container_name: pcloud
    privileged: true
    environment:
      PCLOUD_LOGIN: "MY_EMAIL"
    volumes:
      - /mypath/script.sh:/home/pcloud/script.sh
      - data2backup:/data
      - /dev/fuse:/dev/fuse
      - /mypath/my_password.txt:/home/pcloud/my_password.txt
```      

