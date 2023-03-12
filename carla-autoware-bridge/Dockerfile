FROM --platform=$BUILDPLATFORM jerry73204/autoware:$TARGETARCH AS carla-autoware-bridge-prebuild
ARG TARGETARCH
ARG GIT_REF

SHELL ["/usr/bin/bash", "-c"]

# Install dependencies
WORKDIR /root
RUN apt install -y clang
RUN apt install -y ros-galactic-moveit-msgs

# Install Rust toolchain
WORKDIR /root
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | \
    bash -s -- --default-toolchain stable -y
RUN echo 'source $HOME/.cargo/env' >> /root/.bashrc

# Build bridge
WORKDIR /root
RUN git clone \
    https://github.com/evshary/carla_autoware_zenoh_bridge.git \
    carla_autoware_zenoh_bridge-${GIT_REF}
RUN cd carla_autoware_zenoh_bridge-${GIT_REF} && \
    git checkout ${GIT_REF}
RUN source /root/.cargo/env && \
    source /root/autoware/install/setup.bash && \
    cd carla_autoware_zenoh_bridge-${GIT_REF} && \
    cargo build --release
RUN mv \
    carla_autoware_zenoh_bridge-${GIT_REF} \
    carla_autoware_zenoh_bridge

# Install poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Build Carla agent example
WORKDIR /root
RUN git clone \
    https://github.com/RogerJung/carla_autoware_zenoh_bridge.git \
    agent
WORKDIR /root/agent/carla_agent
RUN git checkout c30bea0503a0f9c91a1b349db426d0e678e61232
RUN /root/.local/bin/poetry install

COPY data/run_bridge.sh /run_bridge.sh
COPY data/run_agent.sh /run_agent.sh

FROM carla-autoware-bridge-prebuild AS carla-autoware-bridge
WORKDIR /
ENTRYPOINT ["./run_bridge.sh"]

FROM carla-autoware-bridge-prebuild AS carla-agent
WORKDIR /root/agent/carla_agent
ENTRYPOINT ["/run_agent.sh"]
