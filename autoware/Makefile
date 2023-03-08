.PHONY: default build push-image push-manifest

target := jerry73204/carla-autoware
arch := $(shell uname -m)

default: build

build: CARLA_0.9.14.tar.gz AdditionalMaps_0.9.14.tar.gz GeographicLib.tar.xz
ifeq ($(arch), x86_64)
	docker buildx build \
		--platform linux/amd64 \
		--target autoware-prebuild \
		-t $(target):galactic-prebuild-amd64 \
		.
	docker buildx build \
		--platform linux/amd64 \
		--target autoware \
		-t $(target):galactic-amd64 \
		.
else ifeq ($(arch), aarch64)
	docker buildx build \
		--platform linux/arm64/v8 \
		--target autoware-prebuild \
		-t $(target):galactic-prebuild-arm64 \
		.
	docker buildx build \
		--platform linux/arm64/v8 \
		--target autoware \
		-t $(target):galactic-arm64 \
		.
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-image:
ifeq ($(arch), x86_64)
	docker push $(target):galactic-prebuild-amd64
	docker push $(target):galactic-amd64
else ifeq ($(arch), aarch64)
	docker push $(target):galactic-prebuild-arm64
	docker push $(target):galactic-arm64
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-manifest:
	docker manifest create $(target):galactic \
		$(target):galactic-amd64
	docker manifest push $(target):galactic

	docker manifest create $(target):galactic-prebuild \
		$(target):galactic-prebuild-amd64
	docker manifest push $(target):galactic-prebuild

CARLA_0.9.14.tar.gz:
	curl --parallel https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.14.tar.gz

AdditionalMaps_0.9.14.tar.gz:
	curl --parallel https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.14.tar.gz
