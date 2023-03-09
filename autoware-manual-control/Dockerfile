FROM --platform=$BUILDPLATFORM jerry73204/autoware:$TARGETARCH AS autoware_manual_control
ARG TARGETARCH

SHELL ["/usr/bin/bash", "-c"]

RUN mkdir -p /root/autoware_manual_control_ws/src
WORKDIR /root/autoware_manual_control_ws/src
RUN git clone https://github.com/evshary/autoware_manual_control.git
WORKDIR /root/autoware_manual_control_ws
RUN source /root/autoware/install/setup.bash && \
    colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

ENTRYPOINT source install/setup.bash && \
    ros2 run autoware_manual_control keyboard_control

# # Install dev tools
# RUN apt install -y nano
# RUN apt install -y vim
# RUN apt install -y screen
# RUN apt install -y tmux
# RUN apt install -y emacs-nox
