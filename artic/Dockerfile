FROM anydsl/thorin

LABEL website="https://anydsl.github.io"

ENV ARTIC_BRANCH=master
ARG CMAKE_MAKE_FLAGS=-j4

RUN wget -q --no-check-certificate https://github.com/anydsl/artic/archive/${ARTIC_BRANCH}.tar.gz \
 && tar -xf ${ARTIC_BRANCH}.tar.gz \
 && rm ${ARTIC_BRANCH}.tar.gz \
 && mv artic-${ARTIC_BRANCH} artic

RUN mkdir -p artic/build \
 && cd artic/build \
 && cmake ../ \
        -DCMAKE_BUILD_TYPE:STRING=Release \
 && cmake --build . -- ${CMAKE_MAKE_FLAGS}

ENV Artic_DIR=/opt/anydsl/artic/build/share/anydsl/cmake

CMD ["/opt/anydsl/artic/build/bin/artic", "--help"]
