FROM anydsl/build-base

LABEL website="https://anydsl.github.io"

WORKDIR /opt

ENV LLVM_VERSION=5.0.2
ARG RV_BRANCH=release_50
ARG CMAKE_BUILD_TYPE=Debug
ARG CMAKE_MAKE_FLAGS=-j4

RUN wget -q http://llvm.org/releases/${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz \
 && tar -xf llvm-${LLVM_VERSION}.src.tar.xz \
 && rm llvm-${LLVM_VERSION}.src.tar.xz \
 && mv llvm-${LLVM_VERSION}.src llvm-source \
 && wget -q https://raw.githubusercontent.com/AnyDSL/anydsl/master/gcc8-llvm.patch \
 && cd llvm-source \
 && patch -p1 -i ../gcc8-llvm.patch \
 && cd tools \
 && wget -q http://llvm.org/releases/${LLVM_VERSION}/cfe-${LLVM_VERSION}.src.tar.xz \
 && tar xf cfe-${LLVM_VERSION}.src.tar.xz \
 && rm cfe-${LLVM_VERSION}.src.tar.xz \
 && mv cfe-${LLVM_VERSION}.src clang \
 && wget https://github.com/cdl-saarland/rv/archive/${RV_BRANCH}.tar.gz \
 && tar -xf ${RV_BRANCH}.tar.gz \
 && rm ${RV_BRANCH}.tar.gz \
 && mv rv-${RV_BRANCH} rv

RUN mkdir -p llvm-build \
 && mkdir -p llvm-install \
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
