FROM anydsl/thorin

MAINTAINER Stefan Lemme <stefan.lemme@dfki.de>

ENV IMPALA_BRANCH master

RUN wget -q https://github.com/anydsl/impala/archive/${IMPALA_BRANCH}.tar.gz \
 && tar -xf ${IMPALA_BRANCH}.tar.gz \
 && rm ${IMPALA_BRANCH}.tar.gz \
 && mv impala-${IMPALA_BRANCH} impala \
 && mkdir -p impala/build

#ADD FindHalf.cmake /opt/anydsl/thorin/runtime/cmake/modules/

RUN cd impala/build \
 && cmake ../ \
        -DCMAKE_BUILD_TYPE:STRING=${BUILD_TYPE}

RUN cd impala/build \
 && make
#&& make install \
# && cd .. \
# && rm -rf build

ENV PATH "$PATH:/opt/anydsl/impala/build/bin"

CMD ["impala", "--help"]

