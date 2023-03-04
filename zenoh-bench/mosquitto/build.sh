#!/usr/bin/env bash
set -e
cmake -B build -S mosquitto-1.6.9 \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_INSTALL_PREFIX=/usr
cmake --build build --parallel
