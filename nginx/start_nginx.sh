#!/usr/bin/env bash
export DOLLAR='$'
envsubst < /etc/nginx/conf.d/site.conf.dist > /etc/nginx/conf.d/site.conf
nginx -g "daemon off;"
