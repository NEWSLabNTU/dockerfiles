#!/usr/bin/env bash
source /root/autoware_manual_control_ws/install/setup.bash
ros2 launch /root/autoware_manual_control_ws/relay.launch.xml &
ros2 run autoware_manual_control keyboard_control $@
