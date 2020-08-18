FROM anydsl/build-base as builder

LABEL website="https://anydsl.github.io"

WORKDIR /opt

ENV LLVM_VERSION=10.0.0
ARG RV_BRANCH=release/10.x
ARG CMAKE_MAKE_FLAGS=-j4

RUN wget -q https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/llvm-project-${LLVM_VERSION}.tar.xz \
 && tar -xf llvm-project-${LLVM_VERSION}.tar.xz \
 && rm llvm-project-${LLVM_VERSION}.tar.xz \
 && mv llvm-project-${LLVM_VERSION} llvm-project

RUN cd llvm-project \
 && wget -q https://raw.githubusercontent.com/AnyDSL/anydsl/master/nvptx_feature_ptx60.patch \
 && patch -p1 -i nvptx_feature_ptx60.patch

RUN cd llvm-project \
 && git clone https://github.com/cdl-saarland/rv --branch ${RV_BRANCH} --recursive rv

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
        -DLLVM_EXTERNAL_PROJECTS="rv" \
        -DLLVM_EXTERNAL_RV_SOURCE_DIR:PATH="/opt/llvm-project/rv" \
        -DLLVM_TARGETS_TO_BUILD="AArch64;AMDGPU;ARM;NVPTX;X86"

RUN cmake --build /opt/llvm-build --target install -- ${CMAKE_MAKE_FLAGS}

FROM anydsl/build-base
WORKDIR /opt

COPY --from=builder /opt/llvm /opt/llvm/

RUN ls -al /opt/llvm/
ENV LLVM_DIR /opt/llvm/lib/cmake/llvm

CMD ["/opt/llvm/bin/clang", "--version"]

