FROM alpine:latest

MAINTAINER Stefan Lemme <stefan.lemme@dfki.de>

WORKDIR /opt

RUN apk update \
 && apk add --no-cache build-base cmake zlib-dev unzip python3 openssl

CMD ["cmake", "--version"]

