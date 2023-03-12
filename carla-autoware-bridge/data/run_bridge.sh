#!/usr/bin/env bash
source /root/autoware/install/setup.bash
export RUST_LOG=c=info
/root/carla_autoware_zenoh_bridge/target/release/carla_autoware_zenoh_bridge $@
