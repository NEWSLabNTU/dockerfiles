FROM --platform=$BUILDPLATFORM ubuntu:20.04 AS base-env
ARG TARGETARCH

SHELL ["/usr/bin/bash", "-c"]

# apt update
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
COPY data/sources.list.$TARGETARCH /etc/apt/sources.list
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y git dialog sudo tzdata keyboard-configuration
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt install -y curl
RUN apt install -y build-essential

FROM base-env AS rust-env

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    bash -s -- --default-toolchain stable -y
RUN echo 'source $HOME/.cargo/env' >> /root/.bashrc

FROM rust-env AS zenohd-prebuild

WORKDIR /root
RUN git clone -b 0.7.0-rc https://github.com/eclipse-zenoh/zenoh.git zenoh

WORKDIR /root/zenoh
RUN source /root/.cargo/env && \
    cargo build --all-targets --release

WORKDIR /
ENTRYPOINT ["/root/zenoh/target/release/zenohd"]
