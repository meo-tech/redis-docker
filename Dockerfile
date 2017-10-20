###################################
# Redis from Source on Alpine Linux
###################################

# base
FROM alpine:latest

# maintainer
MAINTAINER Marcus Schuh <mschuh@meo-tech.de>

# change to /tmp
WORKDIR /tmp

# environment
ENV REDIS_VER redis-4.0.2

# update & install essential tools
RUN apk --update add wget build-base 

# Redis source
RUN wget http://download.redis.io/releases/${REDIS_VER}.tar.gz && \
    tar -zxvf ${REDIS_VER}.tar.gz && \
    rm -rf ${REDIS_VER}.tar.gz && \
    cd ${REDIS_VER} && \
    make && \
    make install && \
    apk del build-base && \
    rm -rf /tmp/${REDIS_VER} && \
    rm -rf /var/cache/apk/*

# expose ports
EXPOSE 6379

# start Redis
CMD ["redis-server"]
