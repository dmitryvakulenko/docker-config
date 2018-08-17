FROM golang:1.10.3-alpine
MAINTAINER Dmitry Vakulenko

RUN apk add git gcc libc-dev \
    && go get -u github.com/derekparker/delve/cmd/dlv \
    && cp /go/bin/dlv /usr/local/bin

