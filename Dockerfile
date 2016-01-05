###################################
# Redis from Source on Alpine Linux
###################################

# Base Image
FROM alpine:3.1

# Maintainer Information
MAINTAINER Marcus Schuh <mschuh@meo-tech.de>

# Change to /tmp
WORKDIR /tmp

# Environment
ENV REDIS_VER redis-3.0.6

# Clean and Update the System
RUN apk --update add wget build-base 

# NGINX Source
RUN wget http://download.redis.io/releases/${REDIS_VER}.tar.gz && \
    tar -zxvf ${REDIS_VER}.tar.gz && \
    rm -rf ${REDIS_VER}.tar.gz && \
    cd ${REDIS_VER} && \
    make && \
    make install && \
    apk del build-base && \
    rm -rf /tmp/${REDIS_VER} && \
    rm -rf /var/cache/apk/*

# Expose Ports
EXPOSE 6379

# Start NGINX
#CMD ["redis-server"]
ENTRYPOINT ["redis-server"]
