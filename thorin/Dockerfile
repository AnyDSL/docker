FROM anydsl/llvm

MAINTAINER Stefan Lemme <stefan.lemme@dfki.de>

ENV HALF_VERSION 1.11.0
ENV THORIN_BRANCH master
ENV BUILD_TYPE Release

RUN wget http://downloads.sourceforge.net/project/half/half/${HALF_VERSION}/half-${HALF_VERSION}.zip \
 && unzip half-${HALF_VERSION}.zip \
 && rm half-${HALF_VERSION}.zip

ENV Half_DIR /opt/anydsl/half-${HALF_VERSION}/include

RUN wget https://github.com/anydsl/thorin/archive/${THORIN_BRANCH}.tar.gz \
 && tar -xf ${THORIN_BRANCH}.tar.gz \
 && rm ${THORIN_BRANCH}.tar.gz \
 && mv thorin-${THORIN_BRANCH} thorin

RUN mkdir -p thorin/build \
 && cd thorin/build \
 && cmake ../ \
        -DCMAKE_BUILD_TYPE:STRING=${BUILD_TYPE} \
 && cmake --build .

ENV THORIN_DIR /opt/anydsl/thorin
