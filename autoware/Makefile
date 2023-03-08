.PHONY: default build push-image push-manifest

target := jerry73204/carla-autoware
arch := $(shell uname -m)

default: build

build:
ifeq ($(arch), x86_64)
	docker buildx build --platform linux/amd64 -t $(target):galactic-amd64 .
else ifeq ($(arch), aarch64)
	docker buildx build --platform linux/arm64/v8 -t $(target):galactic-arm64 .
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-image:
ifeq ($(arch), x86_64)
	docker push $(target):galactic-amd64
else ifeq ($(arch), aarch64)
	docker push $(target):galactic-arm64
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-manifest:
	docker manifest create $(target):galactic $(target):galactic-amd64 $(target):galactic-arm64
	docker manifest push $(target):galactic
