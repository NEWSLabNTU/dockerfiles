.PHONY: default \
	build \
	push-image \
	push-manifest \
	remove-manifest

bridge_target := jerry73204/carla-autoware-bridge
agent_target := jerry73204/carla-agent
git_ref = 3b8601d6f985ca68a7be4a41822f9e684ad3bf43
arch := $(shell uname -m)

default: build

build:
ifeq ($(arch), x86_64)
	docker buildx build \
		--platform linux/amd64 \
		--target carla-autoware-bridge \
		--build-arg GIT_REF=$(git_ref) \
		-t $(bridge_target):amd64 \
		.
	docker buildx build \
		--platform linux/amd64 \
		--target carla-agent \
		--build-arg GIT_REF=$(git_ref) \
		-t $(agent_target):amd64 \
		.
else ifeq ($(arch), aarch64)
	docker buildx build \
		--platform linux/arm64/v8 \
		--target carla-autoware-bridge \
		--build-arg GIT_REF=$(git_ref) \
		-t $(bridge_target):arm64 \
		.
	docker buildx build \
		--platform linux/arm64/v8 \
		--target carla-agent \
		--build-arg GIT_REF=$(git_ref) \
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

remove-manifest:
	docker manifest rm $(bridge_target):latest
	docker manifest rm $(agent_target):latest
