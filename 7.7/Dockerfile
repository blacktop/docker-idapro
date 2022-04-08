FROM --platform=linux/amd64 ubuntu:trusty

ENV IDA_URL https://out7.hex-rays.com/files/idafree77_linux.run

# RUN dpkg --add-architecture i386 \
#     && apt-get update && apt-get install -y libc6-i686:i386 \
#                                             libexpat1:i386 \
#                                             libffi6:i386 \
#                                             libfontconfig1:i386 \
#                                             libfreetype6:i386 \
#                                             libgcc1:i386 \
#                                             libglib2.0-0:i386 \
#                                             libice6:i386 \
#                                             libpcre3:i386 \
#                                             libpng12-0:i386 \
#                                             libsm6:i386 \
#                                             libstdc++6:i386 \
#                                             libuuid1:i386 \
#                                             libx11-6:i386 \
#                                             libxau6:i386 \
#                                             libxcb1:i386 \
#                                             libxdmcp6:i386 \
#                                             libxext6:i386 \
#                                             libxrender1:i386 \
#                                             zlib1g:i386 \
#                                             libx11-xcb1:i386 \
#                                             libdbus-1-3:i386 \
#                                             libxi6:i386 \
#                                             libsm6:i386 \
#                                             libcurl3:i386 \
#                                             libglu1-mesa:i386 \
RUN \
    apt-get update \
    && apt-get install -y --fix-missing \
                            libxcb-xinerama0 \
                            lib32gcc1 \
                            libfontconfig \
                            libfreetype6 \
                            libglib2.0-0 \
                            libsm6 \
                            libssl-dev \
                            libstdc++6 \
                            libxext6 \
                            libxrender1 \
                            lsb-core \
                            qt5-default \
    && apt-get install -y fontconfig python3-pip ca-certificates wget git --no-install-recommends \
    && wget --progress=bar:force -O /tmp/idafree.run ${IDA_URL} \
    && chmod +x /tmp/idafree.run \
    && /tmp/idafree.run --mode unattended --prefix /ida \
    && echo "===> Clean up unnecessary files..." \
    && apt-get purge -y --auto-remove wget ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/* /var/tmp/*

RUN touch /ida/license.displayed

ENV QT_DEBUG_PLUGINS=1

WORKDIR /ida

ENTRYPOINT ["ida64"]