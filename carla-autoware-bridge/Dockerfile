FROM --platform=$BUILDPLATFORM jerry73204/autoware:$TARGETARCH AS carla-autoware-bridge-prebuild
ARG TARGETARCH

SHELL ["/usr/bin/bash", "-c"]

# Install dependencies
WORKDIR /root
RUN apt install -y clang
RUN apt install -y ros-galactic-moveit-msgs

# Setup Rust toolchain
COPY --from=rust-env /root/.rustup /root/.rustup
COPY --from=rust-env /root/.cargo /root/.cargo
RUN echo 'source $HOME/.cargo/env' >> /root/.bashrc

# Build bridge
WORKDIR /root
RUN git clone https://github.com/evshary/carla_autoware_zenoh_bridge.git
RUN source /root/.cargo/env && \
    source /root/autoware/install/setup.bash && \
    cd carla_autoware_zenoh_bridge && \
    cargo build --release

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

COPY data/entrypoint.sh /entrypoint.sh
COPY data/run_agent.sh /run_agent.sh

FROM carla-autoware-bridge-prebuild AS carla-autoware-bridge
WORKDIR /
ENTRYPOINT ["./entrypoint.sh"]

FROM carla-autoware-bridge-prebuild AS carla-agent
WORKDIR /root/agent/carla_agent
ENTRYPOINT ["/run_agent.sh"]
