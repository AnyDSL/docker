FROM alpine:latest

MAINTAINER Stefan Lemme <stefan.lemme@dfki.de>

WORKDIR /opt

RUN apk update \
 && apk add --no-cache build-base bash cmake zlib-dev unzip python openssl

CMD ["cmake", "--version"]

