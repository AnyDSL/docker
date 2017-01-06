FROM debian:latest
#FROM gcc:5

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
        -DLLVM_TOOL_LLVM_AS_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_AS_FUZZER_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_BCANALYZER_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_COV_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_CXXDUMP_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_C_TEST_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_DIFF_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_DIS_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_DWARFDUMP_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_DWP_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_EXTRACT_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_GO_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_JITLISTENER_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_MCMARKUP_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_MC_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_MC_FUZZER_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_NM_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_OBJDUMP_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_PDBDUMP_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_PROFDATA_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_READOBJ_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_RTDYLD_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_SHLIB_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_SIZE_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_SPLIT_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_STRESS_BUILD:BOOL=OFF \
        -DLLVM_TOOL_LLVM_SYMBOLIZER_BUILD:BOOL=OFF \
        -DLLVM_TOOL_MSBUILD_BUILD:BOOL=OFF \
        -DLLVM_TOOL_OBJ2YAML_BUILD:BOOL=OFF \
        -DLLVM_TOOL_OPT_BUILD:BOOL=OFF \
        -DLLVM_TOOL_SANCOV_BUILD:BOOL=OFF \
        -DLLVM_TOOL_VERIFY_USELISTORDER_BUILD:BOOL=OFF \
        -DLLVM_TOOL_XCODE_TOOLCHAIN_BUILD:BOOL=OFF \
        -DLLVM_TOOL_YAML2OBJ_BUILD:BOOL=OFF \
        -DLLVM_TARGETS_TO_BUILD="AArch64;AMDGPU;ARM;NVPTX;X86"

RUN cd llvm/build \
 && make -j install \
 && cd .. \
 && ls -al /usr/local/bin \
 && rm -rf build

ENV LLVM_DIR /usr/local/share/llvm/cmake

CMD ["clang", "--version"]

