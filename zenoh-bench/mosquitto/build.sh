#!/usr/bin/env bash
set -e
make -j$(nproc) -C mosquitto-1.6.9
