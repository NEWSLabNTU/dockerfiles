.PHONY: default build clean

default: build

build:
	docker build -t jerry73204/veloview:5.1 .
	docker save jerry73204/veloview:5.1 | zstd -T0 > image.tar.zst

clean:
