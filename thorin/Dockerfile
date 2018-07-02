FROM anydsl/llvm

LABEL website="https://anydsl.github.io"

ENV HALF_VERSION=1.12.0
ARG THORIN_BRANCH=master
ARG THORIN_PROFILE=false
ARG CMAKE_MAKE_FLAGS=-j4

WORKDIR /opt/anydsl

RUN wget http://downloads.sourceforge.net/project/half/half/${HALF_VERSION}/half-${HALF_VERSION}.zip \
 && unzip -d half-${HALF_VERSION} half-${HALF_VERSION}.zip \
 && rm half-${HALF_VERSION}.zip

ENV Half_DIR /opt/anydsl/half-${HALF_VERSION}/include

RUN wget https://github.com/anydsl/thorin/archive/${THORIN_BRANCH}.tar.gz \
 && tar -xf ${THORIN_BRANCH}.tar.gz \
 && rm ${THORIN_BRANCH}.tar.gz \
 && mv thorin-${THORIN_BRANCH} thorin

RUN mkdir -p thorin/build \
 && cd thorin/build \
 && cmake ../ \
        -DCMAKE_BUILD_TYPE:STRING=Release \
        -DTHORIN_PROFILE:BOOL=${THORIN_PROFILE} \
 && cmake --build . -- ${CMAKE_MAKE_FLAGS}

ENV Thorin_DIR /opt/anydsl/thorin/build/share/anydsl/cmake
