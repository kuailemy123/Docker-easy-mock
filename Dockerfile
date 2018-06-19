FROM node:8.11.2-alpine
MAINTAINER Lework <lework@yeah.net>

ARG TZ=Asia/Shanghai

ENV MOCK_VERSION=1.6.0 \
    PORT=7300 \
    MONGODB=localhost \
    REDIS_PORT=6379 REDIS_HOST=localhost REDIS_PASSWORD='' REDIS_DB=0

COPY entrypoint.sh  /usr/bin/entrypoint.sh

RUN apk --update -t --no-cache add tzdata && \
    apk --no-cache --virtual .fetch-deps add gnupg ca-certificates openssl && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    wget -O /tmp/easy-mock.tar.gz  http://github.com/easy-mock/easy-mock/archive/v${MOCK_VERSION}.tar.gz && \
    tar -xvf /tmp/easy-mock.tar.gz -C /usr/local/ && \
    cd /usr/local/easy-mock-${MOCK_VERSION}/ && \
    yarn install && \
    ln -s /usr/local/easy-mock-${MOCK_VERSION} /usr/local/easy-mock && \
    chmod +x /usr/bin/entrypoint.sh && \
    apk del .fetch-deps && \
    rm -rf /var/cache/apk/* /tmp/*

EXPOSE 7300

CMD /usr/bin/entrypoint.sh
