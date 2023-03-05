.PHONY: default build push-image push-manifest

target := jerry73204/zenoh-bench
arch := $(shell uname -m)

default: build

build:
ifeq ($(arch), x86_64)
	docker buildx build --platform linux/amd64 -t $(target):amd64 .
else ifeq ($(arch), aarch64)
	docker build --platform linux/arm64/v8 -t $(target):arm64 .
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-image:
ifeq ($(arch), x86_64)
	docker push $(target)
else ifeq ($(arch), aarch64)
	docker push $(target)
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-manifest:
	docker manifest create $(target):latest $(target):amd64 $(target):arm64
	docker manifest push $(target):latest
