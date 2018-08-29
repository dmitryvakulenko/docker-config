FROM golang:1.10.3-alpine
MAINTAINER Dmitry Vakulenko

RUN apk --no-cache add tini \
    && apk --no-cache add --virtual build-dependencies git gcc musl-dev tzdata \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && go get -u github.com/derekparker/delve/cmd/dlv \
    && cp /go/bin/dlv /usr/local/bin \
    # clean
    && find /usr/local/go -depth -type d -name test -exec rm -rf {} \; \
    && find /usr/local/go -depth -type d -name testdata -exec rm -rf {} \; \
    && rm -rf /usr/local/go/doc /usr/local/go/api /usr/local/go/misc/trace /go/src/* /var/cache/* /var/lib/apk* \
    && apk del --purge -r build-dependencies

ENTRYPOINT ["/sbin/tini", "--"]