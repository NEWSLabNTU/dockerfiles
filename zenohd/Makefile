.PHONY: default \
	build \
	push-image \
	push-manifest \
	remove-manifest

target := jerry73204/zenohd
arch := $(shell uname -m)

default: build

ifeq ($(arch), x86_64)
build: data/sources.list.amd64
	docker buildx build --platform linux/amd64 -t $(target):amd64 .
else ifeq ($(arch), aarch64)
build: data/sources.list.arm64
	docker buildx build --platform linux/arm64/v8 -t $(target):arm64 .
else
build:
	@echo "Architecture $(arch) not supported"
	@false
endif

ifeq ($(arch), x86_64)
push-image:
	docker push $(target):amd64
else ifeq ($(arch), aarch64)
push-image:
	docker push $(target):arm64
else
push-image:
	@echo "Architecture $(arch) not supported"
	@false
endif

push-manifest:
	docker manifest create $(target):latest $(target):amd64
	docker manifest push $(target):latest

remove-manifest:
	docker manifest rm $(target):latest
