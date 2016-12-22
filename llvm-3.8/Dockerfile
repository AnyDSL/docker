FROM debian:latest

MAINTAINER Stefan Lemme <stefan.lemme@dfki.de>

WORKDIR /opt/anydsl

ENV LLVM_VERSION 3.8.1
ENV BUILD_TYPE Debug

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -q \
 && apt-get upgrade -y -q \
 && apt-get install -y --no-install-recommends wget cmake xz-utils unzip

RUN wget --progress=dot:mega http://llvm.org/releases/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz \
 && tar -xf llvm-${LLVM_VERSION}.src.tar.xz \
 && rm llvm-${LLVM_VERSION}.src.tar.xz \
 && mv llvm-${LLVM_VERSION}.src llvm \
 && cd llvm/tools \
 && wget --progress=dot:mega http://llvm.org/releases/${LLVM_VERSION}/cfe-${LLVM_VERSION}.src.tar.xz \
 && tar xf cfe-${LLVM_VERSION}.src.tar.xz \
 && rm cfe-${LLVM_VERSION}.src.tar.xz \
 && mv cfe-${LLVM_VERSION}.src clang


RUN apt-get install -y --no-install-recommends build-essential python

RUN mkdir -p llvm/build \
 && cd llvm/build \
 && cmake ../ \
        -DCMAKE_BUILD_TYPE:STRING=${BUILD_TYPE} \
        -DCMAKE_INSTALL_PREFIX:PATH="/usr/local" \
        -DLLVM_ENABLE_RTTI:BOOL=ON \
        -DLLVM_INCLUDE_TESTS:BOOL=OFF \
        -DLLVM_TARGETS_TO_BUILD="AArch64;AMDGPU;ARM;NVPTX;X86"

RUN cd llvm/build \
 && make -j4 install \
 && cd .. \
 && rm -rf build

ENV LLVM_DIR /usr/local/share/llvm/cmake

CMD ["clang", "--version"]

