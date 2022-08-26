#!/bin/bash
set -eu

CMAKE_MAKE_FLAGS=-j8

#docker pull anydsl/build-base
docker build -t anydsl/build-base build-base
docker build -t anydsl/llvm    --build-arg CMAKE_MAKE_FLAGS=${CMAKE_MAKE_FLAGS} llvm
docker build -t anydsl/thorin  --build-arg CMAKE_MAKE_FLAGS=${CMAKE_MAKE_FLAGS} thorin
docker build -t anydsl/artic   --build-arg CMAKE_MAKE_FLAGS=${CMAKE_MAKE_FLAGS} artic
docker build -t anydsl/impala  --build-arg CMAKE_MAKE_FLAGS=${CMAKE_MAKE_FLAGS} impala
docker build -t anydsl/runtime --build-arg CMAKE_MAKE_FLAGS=${CMAKE_MAKE_FLAGS} runtime

docker push anydsl/build-base
docker push anydsl/llvm
docker push anydsl/thorin
docker push anydsl/artic
docker push anydsl/impala
docker push anydsl/runtime
