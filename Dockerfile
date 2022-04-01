FROM ubuntu:20.04

USER root

RUN adduser --system --shell /bin/bash pcloud && \
apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata && \
apt-get install -y git cmake zlib1g-dev libboost-system-dev libboost-program-options-dev libpthread-stubs0-dev libfuse-dev libudev-dev fuse build-essential && \
mkdir console-client && \
git clone https://github.com/pcloudcom/console-client.git console-client/ && \
cd console-client/pCloudCC/lib/pclsync/ && \
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
cd ../.. && \
rm -rf console-client && \
mkdir /pdrive && chown pcloud /pdrive && \
apt-get remove -y --purge git cmake zlib1g-dev libboost-system-dev libboost-program-options-dev libpthread-stubs0-dev libfuse-dev libudev-dev build-essential && \
apt-get -y autoremove && \
apt-get -y clean

COPY scripts/start.sh /start.sh
COPY scripts/script.sh /script.sh

RUN chown pcloud /start.sh && chmod +x /start.sh && chown pcloud /script.sh && chmod +x /script.sh

VOLUME /my_password.txt
VOLUME /dev/fuse
USER pcloud

CMD ["/bin/bash", "/start.sh"]


