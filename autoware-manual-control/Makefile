.PHONY: default \
	build \
	push-image \
	push-manifest

target := jerry73204/autoware_manual_control
arch := $(shell uname -m)

default: build

build:
ifeq ($(arch), x86_64)
	docker buildx build \
		--platform linux/amd64 \
		--target autoware_manual_control \
		-t $(target):amd64 \
		.
else ifeq ($(arch), aarch64)
	docker buildx build \
		--platform linux/arm64/v8 \
		--target autoware_manual_control \
		-t $(target):arm64 \
		.
else
	@echo "Architecture $(arch) not supported"
	@false
endif

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
		$(target):amd64
	docker manifest push $(target):latest
