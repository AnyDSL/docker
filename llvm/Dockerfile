FROM anydsl/build-base as builder

LABEL website="https://anydsl.github.io"

WORKDIR /opt

ENV GIT_SSL_NO_VERIFY=1
ENV LLVM_VERSION=14.0.6
ARG RV_BRANCH=release/14.x
ARG CMAKE_MAKE_FLAGS=-j4

RUN wget -q --no-check-certificate https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/llvm-project-${LLVM_VERSION}.src.tar.xz \
 && tar -xf llvm-project-${LLVM_VERSION}.src.tar.xz \
 && rm llvm-project-${LLVM_VERSION}.src.tar.xz \
 && mv llvm-project-${LLVM_VERSION}.src llvm-project

RUN cd llvm-project \
 && wget -q --no-check-certificate https://raw.githubusercontent.com/AnyDSL/anydsl/master/patches/llvm/amdgpu_icmp_fold.patch \
 && wget -q --no-check-certificate https://raw.githubusercontent.com/AnyDSL/anydsl/master/patches/llvm/nvptx_feature.patch \
 && patch -p1 -i amdgpu_icmp_fold.patch \
 && patch -p1 -i nvptx_feature.patch

RUN cd llvm-project \
 && git clone https://github.com/cdl-saarland/rv.git --branch ${RV_BRANCH} --recursive rv

RUN mkdir -p llvm-build \
 && mkdir -p llvm \
 && cd llvm-build \
 && cmake /opt/llvm-project/llvm \
        -DCMAKE_BUILD_TYPE:STRING=Release \
        -DCMAKE_INSTALL_PREFIX:PATH="/opt/llvm" \
        -DLLVM_BUILD_LLVM_DYLIB:BOOL=ON \
        -DLLVM_LINK_LLVM_DYLIB:BOOL=ON \
        -DLLVM_ENABLE_RTTI:BOOL=ON \
        -DLLVM_ENABLE_PROJECTS:STRING="clang;lld" \
        -DLLVM_EXTERNAL_PROJECTS:STRING="rv" \
        -DLLVM_EXTERNAL_RV_SOURCE_DIR:PATH="/opt/llvm-project/rv" \
        -DLLVM_ENABLE_BINDINGS:BOOL=OFF \
        -DLLVM_INCLUDE_TESTS:BOOL=ON \
        -DLLVM_TARGETS_TO_BUILD:STRING="AArch64;AMDGPU;ARM;NVPTX;X86"

RUN cmake --build /opt/llvm-build --target install -- ${CMAKE_MAKE_FLAGS}

FROM anydsl/build-base
WORKDIR /opt

COPY --from=builder /opt/llvm /opt/llvm/

RUN ls -al /opt/llvm/
ENV LLVM_DIR /opt/llvm/lib/cmake/llvm

CMD ["/opt/llvm/bin/clang", "--version"]
