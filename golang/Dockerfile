FROM golang:alpine
MAINTAINER Dmitry Vakulenko

RUN apk --no-cache add tini musl \
    && apk --no-cache add --virtual build-dependencies git musl-dev gcc tzdata \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && go get -u github.com/derekparker/delve/cmd/dlv \
    && cp /go/bin/dlv /usr/local/bin \
    # clean
    && find /usr/local/go -depth -type d -name test -exec rm -rf {} \; \
    && find /usr/local/go -depth -type d -name testdata -exec rm -rf {} \; \
    && rm -rf /usr/local/go/doc /usr/local/go/api /usr/local/go/misc/trace /go/src/* /var/cache/* /var/lib/apk* \
    && apk del --purge -r build-dependencies \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

ENTRYPOINT ["/sbin/tini", "--"]