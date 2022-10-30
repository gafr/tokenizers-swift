.PHONY: all ffi build clean

all: ffi build

ffi:
	$(MAKE) -C $@

build:
	swift build

clean:
	rm -rf .build
	$(MAKE) -C ffi clean