FROM node:8.9.4-alpine

RUN npm install -g vue-cli \
    && npm cache rm --force \
    && rm -rf /var/cache/apk/*

WORKDIR /usr/src/app
