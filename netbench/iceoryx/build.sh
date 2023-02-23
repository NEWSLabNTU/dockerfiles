#!/usr/bin/env bash
set -e
cd iceoryx-2.0.3
cmake -Bbuild -Hiceoryx_meta \
      -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DBUILD_SHARED_LIBS=ON \
      -DBINDING_C=ON \
      -DEXAMPLES=OFF \
      -DBUILD_TEST=OFF \
      -DINTROSPECTION=OFF \
      -DOUT_OF_TREE=ON \
      -DMAKE_UNIQUE_INCLUDEDIR=OFF
cmake --build build --parallel
