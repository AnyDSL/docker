#!/bin/bash

BUILD_TYPE=Release
CMAKE_MAKE_FLAGS=-j8

docker pull anydsl/build-base
docker build -t anydsl/llvm:5.0.2-${BUILD_TYPE} --build-arg CMAKE_BUILD_TYPE=${BUILD_TYPE} --build-arg CMAKE_MAKE_FLAGS=${CMAKE_MAKE_FLAGS} llvm
docker build -t anydsl/thorin:master-${BUILD_TYPE} --build-arg CMAKE_BUILD_TYPE=${BUILD_TYPE} --build-arg CMAKE_MAKE_FLAGS=${CMAKE_MAKE_FLAGS} thorin
docker build -t anydsl/impala:master-${BUILD_TYPE} --build-arg CMAKE_BUILD_TYPE=${BUILD_TYPE} --build-arg CMAKE_MAKE_FLAGS=${CMAKE_MAKE_FLAGS} impala
docker build -t anydsl/runtime:master-${BUILD_TYPE} --build-arg CMAKE_BUILD_TYPE=${BUILD_TYPE} --build-arg CMAKE_MAKE_FLAGS=${CMAKE_MAKE_FLAGS} runtime

docker push anydsl/llvm:5.0.2-${BUILD_TYPE}
docker push anydsl/thorin:master-${BUILD_TYPE}
docker push anydsl/impala:master-${BUILD_TYPE}
docker push anydsl/runtime:master-${BUILD_TYPE}

if [ "$BUILD_TYPE" = "Release" ]; then
    docker tag anydsl/impala:master-${BUILD_TYPE} anydsl/impala:latest
    docker tag anydsl/runtime:master-${BUILD_TYPE} anydsl/runtime:latest
    docker push anydsl/impala:latest
    docker push anydsl/runtime:latest
fi
