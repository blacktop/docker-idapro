FROM --platform=linux/amd64 ubuntu:focal

ARG IDAPW

ENV DEBIAN_FRONTEND noninteractive

RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime \
    && echo $CONTAINER_TIMEZONE > /etc/timezone

ADD idapro.run /tmp/ida.run

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
    && apt-get install -y python3-pip ca-certificates wget git --no-install-recommends \
    && echo "===> Installing Licensed IDA Pro..." \
    && /tmp/ida.run --mode unattended --prefix /ida --installpassword "${IDAPW}" \
    && mkdir /root/.idapro \
    && echo "===> Clean up unnecessary files..." \
    && apt-get purge -y --auto-remove wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/* /var/tmp/*

# ENV QT_DEBUG_PLUGINS=1
ENV XDG_RUNTIME_DIR /tmp/runtime-root

WORKDIR /ida

ENTRYPOINT ["/ida/ida64"]