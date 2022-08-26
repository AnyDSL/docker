FROM anydsl/impala

LABEL website="https://anydsl.github.io"

RUN apt update \
 && apt -y -qq install --no-install-recommends --no-upgrade libtbb-dev \
 && rm -rf /var/lib/apt/lists/*

ENV RUNTIME_BRANCH=master
ARG RUNTIME_JIT=true
ARG RUNTIME_DEBUG_OUTPUT=false
ARG CMAKE_MAKE_FLAGS=-j4

RUN wget -q --no-check-certificate https://github.com/anydsl/runtime/archive/${RUNTIME_BRANCH}.tar.gz \
 && tar -xf ${RUNTIME_BRANCH}.tar.gz \
 && rm ${RUNTIME_BRANCH}.tar.gz \
 && mv runtime-${RUNTIME_BRANCH} runtime

RUN mkdir -p runtime/build \
 && cd runtime/build \
 && cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DRUNTIME_JIT:BOOL=${RUNTIME_JIT} -DDEBUG_OUTPUT:BOOL=${RUNTIME_DEBUG_OUTPUT} -DCMAKE_NO_SYSTEM_FROM_IMPORTED:BOOL=ON \
 && cmake --build . -- ${CMAKE_MAKE_FLAGS}

ENV AnyDSL_runtime_DIR=/opt/anydsl/runtime/build/share/anydsl/cmake
