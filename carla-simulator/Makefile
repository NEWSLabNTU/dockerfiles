.PHONY: default \
	build \
	push-image \
	push-manifest

target := jerry73204/carla-simulator
arch := $(shell uname -m)

default: build

build: data/CARLA_0.9.14.tar.gz data/AdditionalMaps_0.9.14.tar.gz
	docker buildx build \
		--platform linux/amd64 \
		--target carla-simulator \
		-t $(target):latest \
		.

push-image:
	docker push $(target):latest

data/CARLA_0.9.14.tar.gz:
	cd data && \
		wget -N 'https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/CARLA_0.9.14.tar.gz'

data/AdditionalMaps_0.9.14.tar.gz:
	cd data && \
		wget -N 'https://carla-releases.s3.eu-west-3.amazonaws.com/Linux/AdditionalMaps_0.9.14.tar.gz'
