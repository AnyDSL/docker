FROM anydsl/build-base

MAINTAINER Stefan Lemme <stefan.lemme@dfki.de>

WORKDIR /opt

ENV LLVM_VERSION=5.0.1
ARG CMAKE_BUILD_TYPE=Debug
ARG CMAKE_MAKE_FLAGS=-j4

RUN wget -q http://llvm.org/releases/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz \
 && tar -xf llvm-${LLVM_VERSION}.src.tar.xz \
 && rm llvm-${LLVM_VERSION}.src.tar.xz \
 && mv llvm-${LLVM_VERSION}.src llvm-source \
 && cd llvm-source/tools \
 && wget -q http://llvm.org/releases/${LLVM_VERSION}/cfe-${LLVM_VERSION}.src.tar.xz \
 && tar xf cfe-${LLVM_VERSION}.src.tar.xz \
 && rm cfe-${LLVM_VERSION}.src.tar.xz \
 && mv cfe-${LLVM_VERSION}.src clang
# TODO: add RV

RUN mkdir -p llvm-build \
 && cd llvm-build \
 && cmake /opt/llvm-source \
        -DCMAKE_BUILD_TYPE:STRING=${CMAKE_BUILD_TYPE} \
        -DCMAKE_INSTALL_PREFIX:PATH="/opt/llvm-install" \
        -DBUILD_SHARED_LIBS:BOOL=ON \
        -DLLVM_ENABLE_RTTI:BOOL=ON \
        -DLLVM_TARGETS_TO_BUILD="AArch64;AMDGPU;ARM;NVPTX;X86"

RUN cmake --build /opt/llvm-build --target install -- ${CMAKE_MAKE_FLAGS} \
 && ls -al /opt/llvm-install \
 && rm -rf /opt/llvm-build

ENV LLVM_DIR /opt/llvm-install/lib/cmake/llvm

CMD ["/opt/llvm-install/bin/clang", "--version"]

