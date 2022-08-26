FROM ubuntu:latest

LABEL website="https://anydsl.github.io"

WORKDIR /opt

RUN apt update \
 && apt -y -qq install --no-install-recommends --no-upgrade \
    cmake make g++ wget xz-utils patch unzip git subversion python3-dev \
 && rm -rf /var/lib/apt/lists/*

CMD ["cmake", "--version"]
