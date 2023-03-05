FROM --platform=$BUILDPLATFORM ubuntu:20.04
ARG TARGETARCH

# Configure locale and mirrors
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
COPY sources.list.$TARGETARCH /etc/apt/sources.list
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y git dialog sudo tzdata keyboard-configuration
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Create a /setup dir
RUN mkdir /setup && chown nobody /setup

# Install iceoryx
RUN apt install -y wget
RUN apt install -y build-essential
RUN apt install -y cmake
RUN apt install -y ninja-build
RUN apt install -y libacl1-dev
RUN apt install -y libncurses-dev

COPY --chown=nobody:nobody iceoryx /setup/iceoryx
WORKDIR /setup/iceoryx

USER nobody
RUN ./prepare.sh
RUN ./build.sh

USER root
RUN ./install.sh

# Install cyclonedds
COPY --chown=nobody:nobody cyclonedds /setup/cyclonedds
WORKDIR /setup/cyclonedds

USER nobody
RUN ./prepare.sh
RUN ./build.sh

USER root
RUN ./install.sh


# Install paho-mqtt-c
RUN apt install -y libssl-dev

COPY --chown=nobody:nobody paho-mqtt-c /setup/paho-mqtt-c
WORKDIR /setup/paho-mqtt-c

USER nobody
RUN ./prepare.sh
RUN ./build.sh

USER root
RUN ./install.sh

# Install mosquitto
RUN apt install -y uthash-dev

COPY --chown=nobody:nobody mosquitto /setup/mosquitto
WORKDIR /setup/mosquitto

USER nobody
RUN ./prepare.sh
RUN ./build.sh

USER root
RUN ./install.sh

# Install Rust toolchain
WORKDIR /root

RUN apt install -y curl
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    bash -s -- --default-toolchain stable -y
RUN echo 'source $HOME/.cargo/env' >> /root/.bashrc

# Dev tools
# RUN apt install -y man-pages
RUN apt install -y nano
RUN apt install -y vim
RUN apt install -y screen
RUN apt install -y tmux
RUN apt install -y emacs-nox

# Clean up
RUN rm -r /setup
