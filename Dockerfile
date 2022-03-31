FROM ubuntu:20.04

USER root

RUN adduser --system --shell /bin/bash pcloud && \
apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
apt-get install -y git cmake zlib1g-dev libboost-system-dev libboost-program-options-dev libpthread-stubs0-dev libfuse-dev libudev-dev fuse build-essential && \
mkdir /root/console-client && \
git clone https://github.com/pcloudcom/console-client.git /root/console-client/ && \
cd /root/console-client/pCloudCC/lib/pclsync/ && \
sed -i 's#binapi.pcloud.com#bineapi.pcloud.com#' psynclib.c && \
make clean && \
make fs && \
cd ../mbedtls/ && \
cmake . && \
make clean && \
make && \
cd ../.. && \
cmake . && \
make && \
make install && \
ldconfig && \
cd /root && \
rm -rf /root/console-client && \
apt-get remove -y --purge git cmake zlib1g-dev libboost-system-dev libboost-program-options-dev libpthread-stubs0-dev libfuse-dev libudev-dev build-essential && \
apt-get -y autoremove && \
apt-get -y clean

COPY scripts/start.sh /home/pcloud/start.sh
COPY scripts/pcloud /etc/init.d/pcloud

RUN chown pcloud /home/pcloud/start.sh && chmod +x /home/pcloud/start.sh && chmod +x /etc/init.d/pcloud && update-rc.d pcloud defaults

VOLUME /home/pcloud/my_password.txt
VOLUME /dev/fuse
VOLUME /home/pcloud/script.sh
USER pcloud

CMD ["/bin/bash", "/home/pcloud/script.sh"]


