FROM python:3.11-alpine AS builder
LABEL maintainer="xanld"
LABEL org.label-schema.name="NetConf-Console2 & various tools"
LABEL org.label-schema.docker.cmd="docker run -p 2222:22 -d xanld/netconf-tools"
LABEL description="This is netconf-console2 alpine container image with various added networking tools. \
Based on hellt/netconf-console2-container"
LABEL org.opencontainers.image.source="https://github.com/xanld/netconf-tools"
ARG VERSION=3.0.1

RUN apk --no-cache add \
    # build-base \
    # python3-dev \
    libffi-dev \
    openssl-dev \
    ncurses-dev \
    libxml2-dev \
    libxslt-dev \
    git \
    bash && \
    # netconf-console installation
    pip3 install git+https://bitbucket.org/martin_volf/ncc/@${VERSION}

FROM python:3.11-alpine AS prod
RUN apk add --no-cache \
    python3 \
    curl \
    traceroute \
    tcpdump \
    sudo \
    bash \
    nmap \
    wireshark \
    net-snmp \
    net-snmp-tools \
    iperf \
    openssh && \
    # cleanup
    find /usr/lib/ -name '__pycache__' -print0 | xargs -0 -n1 rm -rf && \
    find /usr/lib/ -name '*.pyc' -print0 | xargs -0 -n1 rm -rf

RUN addgroup --gid 1000 xuser && adduser --home /home/xuser --disabled-password --shell /bin/bash --ingroup xuser --uid 1000 xuser && addgroup xuser wheel && addgroup xuser wireshark 
RUN echo -n 'xuser:xuser' | chpasswd
RUN echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

COPY --from=builder /usr/lib/libx*.* /usr/lib/
COPY --from=builder /usr/lib/libex*.* /usr/lib/
COPY --from=builder /usr/lib/libgcrypt* /usr/lib/
COPY --from=builder /usr/lib/libgpg* /usr/lib/
COPY --from=builder /usr/local/lib/python3.11/site-packages/ /usr/local/lib/python3.11/site-packages/
COPY --from=builder /usr/local/bin/netconf-console2 /usr/local/bin/netconf-console2

EXPOSE 22

WORKDIR /rpc
COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh"]

