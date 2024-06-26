FROM --platform=linux/amd64 ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive
ENV IDA_URL https://out7.hex-rays.com/files/idafree84_linux.run

RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime \
    && echo $CONTAINER_TIMEZONE > /etc/timezone

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
                            fontconfig \
                            libxrender1 \
                            libxtst6 \
                            libxi6 \
                            libsecret-1-0 \
    && apt-get install -y python3-pip ca-certificates wget git --no-install-recommends \
    && wget --progress=bar:force -O /tmp/idafree.run ${IDA_URL} \
    && chmod +x /tmp/idafree.run \
    && echo "===> Installing IDA FREE..." \
    && /tmp/idafree.run --mode unattended --prefix /ida \
    && mkdir /root/.idapro \
    && echo "===> Clean up unnecessary files..." \
    && apt-get purge -y --auto-remove wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/* /var/tmp/*

WORKDIR /ida

# ADD ida.reg /root/.idapro/ida.reg

ENTRYPOINT ["/ida/ida64"]