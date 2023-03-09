.PHONY: default \
	build \
	build_amd64 \
	build_arm64 \
	push-image \
	push-manifest

target := jerry73204/carla-simulator
arch := $(shell uname -m)

default: build

ifeq ($(arch), x86_64)
build: build_amd64
else ifeq ($(arch), aarch64)
build: build_arm64
else
build:
	@echo "Architecture $(arch) not supported"
	@false
endif

build_amd64: data/CARLA_0.9.14.tar.gz data/AdditionalMaps_0.9.14.tar.gz
	docker buildx build \
		--platform linux/amd64 \
		--target carla-simulator \
		-f Dockerfile.amd64 \
		-t $(target):amd64 \
		.

build_arm64:
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
		-f Dockerfile.arm64 \
		-t $(target):arm64 \
		.


push-image:
ifeq ($(arch), x86_64)
	docker push $(target):amd64
else ifeq ($(arch), aarch64)
	docker push $(target):arm64
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-manifest:
	docker manifest create $(target):latest \
		$(target):amd64 \
		$(target):arm64
	docker manifest push $(target):latest

data/CARLA_0.9.14.tar.gz:
	wget -N 'https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.14.tar.gz'

data/AdditionalMaps_0.9.14.tar.gz:
	wget -N 'https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.14.tar.gz'
