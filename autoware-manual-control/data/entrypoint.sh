#!/usr/bin/env bash
source /root/autoware_manual_control_ws/install/setup.bash
ros2 run autoware_manual_control keyboard_control $@
