ARG CMAKE_BUILD_TYPE=Debug

FROM anydsl/impala:master-${CMAKE_BUILD_TYPE}

LABEL website="https://anydsl.github.io"

ENV RUNTIME_BRANCH=master
ARG RUNTIME_JIT=false
ARG CMAKE_MAKE_FLAGS=-j4

RUN wget -q https://github.com/anydsl/runtime/archive/${RUNTIME_BRANCH}.tar.gz \
 && tar -xf ${RUNTIME_BRANCH}.tar.gz \
 && rm ${RUNTIME_BRANCH}.tar.gz \
 && mv runtime-${RUNTIME_BRANCH} runtime

RUN mkdir -p runtime/build \
 && cd runtime/build \
 && cmake .. -DCMAKE_BUILD_TYPE:STRING=${BUILD_TYPE} -DRUNTIME_JIT=${RUNTIME_JIT} \
 && cmake --build . -- ${CMAKE_MAKE_FLAGS}

ENV AnyDSL_runtime_DIR=/opt/anydsl/runtime/build/share/anydsl/cmake
