# pcloud-docker

A "simple" container that connect to EU Pcloud, mount it in /pdrive and execute every 2 second whatever you could have done in binded /script.sh (like take files from a shared volume and send them to pCloudDrive)

## Warnings : 
### Privileges
Never expose services from this container as it needs to have the `--privileged` flag or `CAP_SYS_ADMIN`. 

If only the host administrators can have access to the container and there is only a shared volume and pCloud connection, this ***should*** be ok

### EU Region
There is a `sed -i 's#binapi.pcloud.com#bineapi.pcloud.com#' psynclib.c` before compilation of [pcloudcc](https://github.com/pcloudcom/console-client) to connect to EU servers. I don't know if it is still working for other regions.

### Secrets
Secrets are for docker swarm, i myself run in standalone

## Usage

Define what you want to do with this container with the script.sh binded to `/script.sh`. You'll probably want to send files to pCloud, you can map a shared volume at `/data` or anywhere else, only the script.sh will be using it anyway.

You might need to set permissions to pcloud user on the /data volume dir. I don't know how to do that, i'm using binded volumes

See `compose.yml` :

```
services:
  pcloud : 
    image: pcloud-docker
    container_name: pcloud
    privileged: true
    environment:
      PCLOUD_LOGIN: "MY_EMAIL"
      BACKUP_DIR: "Automated_saves"
    volumes:
      # - /mypath/script.sh:/script.sh
      - data2backup:/data
      - /dev/fuse:/dev/fuse
      - /mypath/my_password.txt:/my_password.txt
```      

