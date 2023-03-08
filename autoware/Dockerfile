FROM --platform=$BUILDPLATFORM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04 AS base-env
ARG TARGETARCH

# apt update
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
COPY sources.list.$TARGETARCH /etc/apt/sources.list
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y git dialog sudo tzdata keyboard-configuration
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt install -y curl

FROM base-env AS ros-env

# Install ROS
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt update -y
RUN apt install -y ros-galactic-desktop
RUN apt install -y ros-dev-tools

FROM ros-env AS autoware-env

# Use Cyclone DDS RMW implementation
RUN wget -O /root/setup.env https://raw.githubusercontent.com/autowarefoundation/autoware/galactic/amd64.env  # Fix to "amd64.env" because "arm64.env" is empty.
RUN . /root/setup.env && \
    rmw_implementation_dashed=$(echo "${rmw_implementation}" | tr '_' '-') && \
    apt install ros-${rosdistro}-${rmw_implementation_dashed} && \
    echo '' >> /etc/bash.bashrc && \
    echo "export RMW_IMPLEMENTATION=${rmw_implementation}" >> /etc/bash.bashrc

# Install pacmod
RUN apt install -y apt-transport-https
RUN sh -c 'echo "deb [trusted=yes] https://s3.amazonaws.com/autonomoustuff-repo/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/autonomoustuff-public.list'
RUN apt update -y
RUN . /root/setup.env && \
    apt install -y ros-${rosdistro}-pacmod3

# Install gdown
RUN apt install -y python3-pip
RUN pip3 install --no-input gdown

# Add EGM2008 geoid grid to geographiclib
RUN apt install -y geographiclib-tools
# RUN geographiclib-get-geoids egm2008-1
WORKDIR /root
COPY GeographicLib.tar.xz.0 GeographicLib.tar.xz.0
COPY GeographicLib.tar.xz.1 GeographicLib.tar.xz.1
RUN cat GeographicLib.tar.xz.0 GeographicLib.tar.xz.1 > GeographicLib.tar.xz
WORKDIR /usr/share
RUN tar -xf /root/GeographicLib.tar.xz
RUN rm /root/GeographicLib.tar.xz /root/GeographicLib.tar.xz.0 /root/GeographicLib.tar.xz.1

# Install pre-commit
RUN clang_format_version=14.0.6 && \
    pip3 install --no-input pre-commit clang-format==${clang_format_version}

# Install go
RUN apt install -y software-properties-common
RUN add-apt-repository -y ppa:longsleep/golang-backports
RUN apt install -y golang

# update rosdep database
RUN . /opt/ros/galactic/setup.sh && \
    rosdep init && \
    rosdep --rosdistro=$ROS_DISTRO update

# Source ROS env in .bashrc
RUN echo '' >> /etc/bash.bashrc && \
    echo 'source /opt/ros/galactic/setup.bash' >> /etc/bash.bashrc

FROM base-env AS carla-preinstall

RUN mkdir /root/carla
WORKDIR /root/carla

COPY CARLA_0.9.14.tar.gz /root/carla
COPY AdditionalMaps_0.9.14.tar.gz /root/carla
RUN tar -xf CARLA_0.9.14.tar.gz
RUN tar -xf AdditionalMaps_0.9.14.tar.gz
RUN rm CARLA_0.9.14.tar.gz AdditionalMaps_0.9.14.tar.gz

FROM rust:1.67.1 AS rust-env

FROM autoware-env AS autoware-prebuild

# download source code
WORKDIR /root
RUN git clone -b galactic https://github.com/autowarefoundation/autoware.git autoware

# build autoware
WORKDIR /root/autoware
RUN mkdir src
RUN vcs import src < autoware.repos
RUN . /opt/ros/galactic/setup.sh && \
    rosdep install -y --from-paths src --ignore-src --rosdistro $ROS_DISTRO
RUN . /opt/ros/galactic/setup.sh && \
    colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

RUN echo '' >> /etc/bash.bashrc && \
    echo 'source /root/autoware/install/setup.bash' >> /etc/bash.bashrc

FROM autoware-prebuild AS carla-autoware

WORKDIR /root
COPY --from=rust-env /usr/local/cargo /usr/local/cargo
COPY --from=carla-preinstall /root/carla /root/carla

# Install dev tools
RUN apt install -y nano
RUN apt install -y vim
RUN apt install -y screen
RUN apt install -y tmux
RUN apt install -y emacs-nox
