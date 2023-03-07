FROM ghcr.io/autowarefoundation/autoware-universe:galactic-latest-cuda-amd64

# apt update
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
COPY sources.list /etc/apt/sources.list
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y git dialog sudo tzdata keyboard-configuration
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Install ROS
# apt install software-properties-common
