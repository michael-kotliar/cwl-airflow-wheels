#!/usr/bin/env bash
docker run --rm --workdir /io -v `pwd`:/io quay.io/pypa/manylinux1_x86_64 /io/build.sh