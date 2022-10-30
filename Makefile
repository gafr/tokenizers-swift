.PHONY: all ffi build

all: ffi build

ffi:
	$(MAKE) -C $@

build:
	swift build