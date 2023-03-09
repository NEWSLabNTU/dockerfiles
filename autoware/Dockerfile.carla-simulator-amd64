FROM --platform=$BUILDPLATFORM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu20.04 AS base-env

SHELL ["/usr/bin/bash", "-c"]

# apt update
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Asia/Taipei /etc/localtime
COPY data/sources.list.amd64 /etc/apt/sources.list
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y git dialog sudo tzdata keyboard-configuration
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt install -y curl

FROM base-env AS carla-simulator

RUN mkdir /root/carla
WORKDIR /root/carla

COPY data/CARLA_0.9.14.tar.gz /root/carla
COPY data/AdditionalMaps_0.9.14.tar.gz /root/carla
RUN tar -xf CARLA_0.9.14.tar.gz
RUN tar -xf AdditionalMaps_0.9.14.tar.gz
RUN rm CARLA_0.9.14.tar.gz AdditionalMaps_0.9.14.tar.gz

# Install dev tools
RUN apt install -y nano
RUN apt install -y vim
RUN apt install -y screen
RUN apt install -y tmux
RUN apt install -y emacs-nox
