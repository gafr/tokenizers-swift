.PHONY: all clean build

SRC_DIR = src

BUILD_DIR = .build

SRC = ${SRC_DIR}/lib.rs ${SRC_DIR}/lib.udl

all: build

${BUILD_DIR}/out_dir.txt: Cargo.toml
	mkdir -p ${BUILD_DIR}
	name=$$(cargo metadata --no-deps --format-version 1 | jq -r ".packages[0].name"); \
	cargo check --message-format json | \
	jq -r "if .reason == \"build-script-executed\" and \
		(.package_id | contains(\"$${name}\")) then .out_dir else empty end" > $@

rustlib: ${BUILD_DIR}/out_dir.txt ${SRC}
	cargo build
	cp -r $$(cat ${BUILD_DIR}/out_dir.txt)/*.{h,swift,modulemap} ${BUILD_DIR}/

swiftmodule: build
	swiftc -parse-as-library \
		-emit-module -emit-module-path ${BUILD_DIR} -module-name math \
		-emit-library -o ${BUILD_DIR}/libmath.dylib \
		-L ./target/debug -ltokenizers_ffi \
  		-I ${BUILD_DIR} \
  		-Xcc -fmodule-map-file=${BUILD_DIR}/mathFFI.modulemap \
  		${BUILD_DIR}/math.swift

build: rustlib swiftmodule

clean:
	cargo clean