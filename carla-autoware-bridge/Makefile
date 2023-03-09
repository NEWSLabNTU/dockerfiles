.PHONY: default \
	build \
	push-image \
	push-manifest

bridge_target := jerry73204/carla-autoware-bridge
agent_target := jerry73204/carla-agent
arch := $(shell uname -m)

default: build

build:
ifeq ($(arch), x86_64)
	docker buildx build \
		--platform linux/amd64 \
		--target carla-autoware-bridge \
		-t $(bridge_target):amd64 \
		.
	docker buildx build \
		--platform linux/amd64 \
		--target carla-agent \
		-t $(agent_target):amd64 \
		.
else ifeq ($(arch), aarch64)
	docker buildx build \
		--platform linux/arm64/v8 \
		--target carla-autoware-bridge \
		-t $(bridge_target):arm64 \
		.
	docker buildx build \
		--platform linux/arm64/v8 \
		--target carla-agent \
		-t $(agent_target):arm64 \
		.
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-image:
ifeq ($(arch), x86_64)
	docker push $(bridge_target):amd64
	docker push $(agent_target):amd64
else ifeq ($(arch), aarch64)
	docker push $(bridge_target):arm64
	docker push $(agent_target):arm64
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push-manifest:
	docker manifest create $(bridge_target):latest \
		$(bridge_target):amd64
	docker manifest push $(bridge_target):latest

	docker manifest create $(agent_target):latest \
		$(agent_target):amd64
	docker manifest push $(agent_target):latest
