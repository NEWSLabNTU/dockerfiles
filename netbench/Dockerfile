FROM archlinux:base-devel-20230212.0.126025

COPY mirrorlist /etc/pacman.d/mirrorlist
COPY makepkg.conf /etc/makepkg.conf
RUN pacman -Sy --noconfirm

RUN mkdir /setup && chown nobody /setup
RUN mkdir /.cache && chown nobody /.cache

# Install yay
RUN pacman -S --noconfirm git go
RUN sudo -u nobody mkdir /setup/yay
COPY yay/PKGBUILD /setup/yay/PKGBUILD
RUN cd /setup/yay && \
    sudo -u nobody makepkg -Ccf
RUN pacman -U --noconfirm /setup/yay/yay-11.3.2-1-x86_64.pkg.tar

# Install iceoryx
RUN pacman -S --noconfirm ninja cmake
RUN sudo -u nobody mkdir /setup/iceoryx
COPY iceoryx/PKGBUILD /setup/iceoryx/PKGBUILD
RUN cd /setup/iceoryx && \
    sudo -u nobody makepkg -Ccf
RUN ls /setup/iceoryx
RUN pacman -U --noconfirm /setup/iceoryx/iceoryx-2.0.3-1-x86_64.pkg.tar

# Install cyclonedds
RUN pacman -S --noconfirm jdk-openjdk maven
RUN sudo -u nobody mkdir /setup/cyclonedds
COPY cyclonedds/PKGBUILD /setup/cyclonedds/PKGBUILD
RUN cd /setup/cyclonedds && \
    sudo -u nobody makepkg -Ccf
RUN ls /setup/cyclonedds
RUN pacman -U --noconfirm /setup/cyclonedds/cyclonedds-0.10.2-1-x86_64.pkg.tar

# Install Kafka
RUN pacman -S --noconfirm kafka
RUN pacman -S --noconfirm librdkafka

# Install MQTT
RUN pacman -S --noconfirm mosquitto
RUN sudo -u nobody mkdir /setup/paho-mqtt-c
COPY paho-mqtt-c/PKGBUILD /setup/paho-mqtt-c/PKGBUILD
RUN cd /setup/paho-mqtt-c && \
    sudo -u nobody makepkg -Ccf
RUN ls /setup/paho-mqtt-c
RUN pacman -U --noconfirm /setup/paho-mqtt-c/paho-mqtt-c-1.3.10-1-x86_64.pkg.tar

# Install Rust toolchain
RUN pacman -S --noconfirm rustup
RUN rustup update
RUN rustup default stable

# Dev tools
RUN pacman -S --noconfirm man-pages
RUN pacman -S --noconfirm nano
RUN pacman -S --noconfirm vim
RUN pacman -S --noconfirm screen
RUN pacman -S --noconfirm tmux
RUN pacman -S --noconfirm emacs-nox

# Clean up
RUN rm -r /setup
