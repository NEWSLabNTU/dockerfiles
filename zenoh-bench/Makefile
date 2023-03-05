.PHONY: default build push

arch := $(shell uname -p)

default: build

build:
ifeq ($(arch), x86_64)
	docker buildx build --platform linux/amd64 -t jerry73204/zenoh-bench .

else ifeq ($(arch), aarch64)
	docker build --platform linux/arm64/v8 -t jerry73204/zenoh-bench .
else
	@echo "Architecture $(arch) not supported"
	@false
endif

push:
	docker push jerry73204/zenoh-bench
