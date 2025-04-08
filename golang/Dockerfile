FROM golang:1.24-alpine
MAINTAINER Dmitry Vakulenko

RUN apk --no-cache add tini musl git openssh bash \
    && apk --no-cache add --virtual build-dependencies git musl-dev gcc tzdata \
    && cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone \
    && go install github.com/go-delve/delve/cmd/dlv@latest \
    # clean
    && find /usr/local/go -depth -type d -name test -exec rm -rf {} \; \
    && find /usr/local/go -depth -type d -name testdata -exec rm -rf {} \; \
    && rm -rf /usr/local/go/doc /usr/local/go/api /usr/local/go/misc/trace /go/src/* /var/cache/* /var/lib/apk* \
    && apk del --purge -r build-dependencies \
    && mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2 \
    && git config --system url."ssh://git@git.hbook.pro:65321".insteadOf "https://gitlab.hbook.pro" \
    && mkdir -p ~/.ssh \
    && echo -e "Host git.hbook.pro\n\tPort 65321" >> ~/.ssh/config && chmod go-rwx -R ~/.ssh \
    && ssh-keyscan -p 65321 -H git.hbook.pro >> ~/.ssh/known_hosts

ENV GOPRIVATE=gitlab.utstech.ru,gitlab.hbook.pro
ENV SSH_AUTH_SOCK=/root/ssh.pid

COPY start /usr/local/bin
RUN chmod a+x /usr/local/bin/start

ENTRYPOINT ["/usr/local/bin/start"]