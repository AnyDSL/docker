FROM alpine:latest

LABEL website="https://anydsl.github.io"

WORKDIR /opt

RUN apk update \
 && apk add --no-cache build-base bash cmake zlib-dev unzip python openssl

CMD ["cmake", "--version"]

