#!/usr/bin/env bash
set -e
make -j$(nproc) -C mosquitto-2.0.15
