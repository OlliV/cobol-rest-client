FROM debian:buster AS base
RUN apt-get update && apt-get -y install libcob4 curl

#FROM base AS build-base
WORKDIR /root
RUN apt-get -y install make gcc gnucobol && \
    curl -s https://install-node.now.sh > install-node.sh && \
    chmod +x install-node.sh && \
    ./install-node.sh --yes

COPY . /root/
RUN cobc -x -free -W RESTclient.cbl \
    get_errno.c \
    errnomessage.cbl \
    httpstatus.cbl \
    connecttoserver.cbl && \
    chmod +x RESTclient
