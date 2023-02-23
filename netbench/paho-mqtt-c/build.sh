#!/usr/bin/env bash
set -e
cmake -B build -S paho.mqtt.c-1.3.10 \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DPAHO_WITH_SSL=TRUE \
      -DPAHO_BUILD_SAMPLES=TRUE
cmake --build build --parallel
