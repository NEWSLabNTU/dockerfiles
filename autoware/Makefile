.PHONY: default \
	build \
	build_bridge \
	build_simulator \
	build_simulator_amd64 \
	build_simulator_arm64 \
	push-image \
	push-manifest

simulator_target := jerry73204/carla-simulator
bridge_target := jerry73204/carla-autoware-bridge
arch := $(shell uname -m)

default: build

build: build_simulator build_bridge

ifeq ($(arch), x86_64)
build_simulator: build_simulator_amd64
else ifeq ($(arch), aarch64)
build_simulator: build_simulator_arm64
else
build_simulator:
	@echo "Architecture $(arch) not supported"
	@false
endif

build_simulator_amd64: data/CARLA_0.9.14.tar.gz data/AdditionalMaps_0.9.14.tar.gz
	docker buildx build \
		--platform linux/amd64 \
		--target carla-simulator \
		-f Dockerfile.carla-simulator-amd64 \
		-t $(simulator_target):amd64 \
		.

build_simulator_arm64:
	cd data; \
	git clone \
		--depth 1 \
		-b carla \
		'git@github.com:CarlaUnreal/UnrealEngine.git' \
		UnrealEngine_4.26 2>/dev/null || \
	git -C UnrealEngine_4.26 checkout carla

	docker buildx build \
		--platform linux/arm64/v8 \
		--target carla-simulator \
		-f Dockerfile.carla-simulator-arm64 \
		-t $(simulator_target):arm64 \
		.


build_bridge: data/GeographicLib.tar.xz.0 data/GeographicLib.tar.xz.1
ifeq ($(arch), x86_64)
	docker buildx build \
		--platform linux/amd64 \
		--target carla-autoware-bridge \
		-f Dockerfile.carla-autoware-bridge \
		-t $(bridge_target):amd64 \
		.
else ifeq ($(arch), aarch64)
	docker buildx build \
		--platform linux/arm64/v8 \
		--target carla-autoware-bridge \
		-f Dockerfile.carla-autoware-bridge \
		-t $(bridge_target):arm64 \
		.
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-image:
ifeq ($(arch), x86_64)
	docker push $(bridge_target):amd64
	docker push $(simulator_target):amd64
else ifeq ($(arch), aarch64)
	docker push $(bridge_target):arm64
	docker push $(simulator_target):arm64
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-manifest:
	docker manifest create $(bridge_target):latest \
		$(target):amd64 \
		$(target):arm64
	docker manifest push $(bridge_target):latest

	docker manifest create $(simulator_target):latest \
		$(target):amd64 \
		$(target):arm64
	docker manifest push $(simulator_target):latest

data/CARLA_0.9.14.tar.gz:
	wget -N 'https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.14.tar.gz'

data/AdditionalMaps_0.9.14.tar.gz:
	wget -N 'https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.14.tar.gz'
