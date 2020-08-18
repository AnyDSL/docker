FROM anydsl/impala

LABEL website="https://anydsl.github.io"

RUN pacman -Syu --noconfirm \
 && pacman -S --noconfirm intel-tbb \
 && rm -rf /var/cache/pacman/pkg/*

ENV RUNTIME_BRANCH=master
ARG RUNTIME_JIT=false
ARG CMAKE_MAKE_FLAGS=-j4

RUN wget -q https://github.com/anydsl/runtime/archive/${RUNTIME_BRANCH}.tar.gz \
 && tar -xf ${RUNTIME_BRANCH}.tar.gz \
 && rm ${RUNTIME_BRANCH}.tar.gz \
 && mv runtime-${RUNTIME_BRANCH} runtime

RUN mkdir -p runtime/build \
 && cd runtime/build \
 && cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -DRUNTIME_JIT=${RUNTIME_JIT} -DCMAKE_NO_SYSTEM_FROM_IMPORTED=ON \
 && cmake --build . -- ${CMAKE_MAKE_FLAGS}

ENV AnyDSL_runtime_DIR=/opt/anydsl/runtime/build/share/anydsl/cmake
