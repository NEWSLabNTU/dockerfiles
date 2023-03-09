FROM --platform=$BUILDPLATFORM jerry73204/autoware AS carla-autoware-bridge
ARG TARGETARCH

WORKDIR /root
RUN apt install -y clang
RUN apt install -y ros-galactic-moveit-msgs

COPY --from=rust-env /root/.rustup /root/.rustup
COPY --from=rust-env /root/.cargo /root/.cargo
RUN echo 'source $HOME/.cargo/env' >> /root/.bashrc

RUN git clone https://github.com/evshary/carla_autoware_zenoh_bridge.git
RUN source /root/.cargo/env && \
    source /root/autoware/install/setup.bash && \
    cd carla_autoware_zenoh_bridge && \
    cargo build --release

# # Install dev tools
# RUN apt install -y nano
# RUN apt install -y vim
# RUN apt install -y screen
# RUN apt install -y tmux
# RUN apt install -y emacs-nox
