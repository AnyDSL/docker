FROM anydsl/artic

LABEL website="https://anydsl.github.io"

ENV IMPALA_BRANCH=master
ARG CMAKE_MAKE_FLAGS=-j4

RUN wget -q --no-check-certificate https://github.com/anydsl/impala/archive/${IMPALA_BRANCH}.tar.gz \
 && tar -xf ${IMPALA_BRANCH}.tar.gz \
 && rm ${IMPALA_BRANCH}.tar.gz \
 && mv impala-${IMPALA_BRANCH} impala

RUN mkdir -p impala/build \
 && cd impala/build \
 && cmake ../ \
        -DCMAKE_BUILD_TYPE:STRING=Release \
 && cmake --build . -- ${CMAKE_MAKE_FLAGS}

ENV Impala_DIR=/opt/anydsl/impala/build/share/anydsl/cmake

CMD ["/opt/anydsl/impala/build/bin/impala", "--help"]
