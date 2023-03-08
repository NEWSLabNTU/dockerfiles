#!/bin/sh
. /opt/ros/galactic/setup.sh
mkdir src
vcs import src < autoware.repos
rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
