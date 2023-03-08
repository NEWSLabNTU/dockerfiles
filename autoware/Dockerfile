FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04 AS autoware

# apt update
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
COPY sources.list /etc/apt/sources.list
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y git dialog sudo tzdata keyboard-configuration
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Install ROS
RUN apt install -y curl
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt update -y
RUN apt install -y ros-galactic-desktop
RUN apt install -y ros-dev-tools

# Use Cyclone DDS RMW implementation
RUN wget -O /root/setup.env https://raw.githubusercontent.com/autowarefoundation/autoware/galactic/amd64.env
RUN . /root/setup.env && \
    rmw_implementation_dashed=$(echo "${rmw_implementation}" | tr '_' '-') && \
    apt install ros-${rosdistro}-${rmw_implementation_dashed} && \
    echo '' >> /etc/bash.bashrc && echo "export RMW_IMPLEMENTATION=${rmw_implementation}" >> /etc/bash.bashrc

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
RUN geographiclib-get-geoids egm2008-1

# Install pre-commit
RUN clang_format_version=14.0.6 && \
    pip3 install --no-input pre-commit clang-format==${clang_format_version}

# Install go
RUN apt install -y software-properties-common
RUN add-apt-repository -y ppa:longsleep/golang-backports
RUN apt install -y golang

# Install dev tools
RUN apt install -y nano
RUN apt install -y vim
RUN apt install -y screen
RUN apt install -y tmux
RUN apt install -y emacs-nox

# update rosdep database
RUN . /opt/ros/galactic/setup.sh && \
    rosdep init && \
    rosdep --rosdistro=$ROS_DISTRO update

# Source ROS env in .bashrc
RUN echo '' >> /etc/bash.bashrc && \
    echo 'source /opt/ros/galactic/setup.bash'


FROM autoware AS autoware-prebuild

# download source code
WORKDIR /root
RUN git clone -b galactic https://github.com/autowarefoundation/autoware.git autoware

# build autoware
WORKDIR /root/autoware
COPY build_autoware.sh build_autoware.sh
RUN ./build_autoware.sh
RUN echo '' >> /etc/bash.bashrc && \
    echo 'source /root/autoware/install/setup.bash'
