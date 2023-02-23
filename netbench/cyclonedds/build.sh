#!/usr/bin/env bash
set -e
cmake -B build -S "cyclonedds-0.10.2" \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_CXX_FLAGS="-march=native -mtune=native -pipe -O3" \
      -DENABLE_SHM=YES
cmake --build build --parallel
