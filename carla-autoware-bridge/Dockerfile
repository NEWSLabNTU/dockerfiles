FROM --platform=$BUILDPLATFORM jerry73204/autoware:$TARGETARCH AS carla-autoware-bridge
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

ENTRYPOINT source /root/autoware/install/setup.bash && \
    env RUST_LOG=c=info /root/carla_autoware_zenoh_bridge/target/release/carla_autoware_zenoh_bridge
