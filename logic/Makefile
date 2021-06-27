unlink:
	unlink ../godot/lib/liblogic.dylib || true

symlink: unlink
	cd ../godot/lib && ln -s ../../logic/target/debug/liblogic.dylib liblogic.dylib

symlink-release: unlink
	cd ../godot/lib && ln -s ../../logic/target/release/liblogic.dylib liblogic.dylib

build-ios:
	cargo lipo --release
	cp target/universal/release/liblogic.a ../godot/lib/ios/liblogic.a
	cp target/universal/release/liblogic.a ../_deploy/liblogic.a

setup-emc:
	git clone https://github.com/emscripten-core/emsdk.git
	cd emsdk
	./emsdk install 2.0.17
	./emsdk activate 2.0.17
	source ./emsdk_env.sh

fix-emc:
	mv "$(EMSDK)/upstream/bin/wasm-opt" "$(EMSDK)/upstream/bin/wasm-opt.bak"
	cp wasm-opt "$(EMSDK)/upstream/bin/wasm-opt"

build-web:
	RUSTFLAGS="-C link-args=-fPIC -C relocation-model=pic" \
	EMMAKEN_CFLAGS="-s STRICT=1 -s SIDE_MODULE=1 -shared -Wl,--no-check-features -all" \
	C_INCLUDE_PATH="$(EMSDK)/upstream/emscripten/cache/sysroot/include/" \
	EMCC_DEBUG=1 \
	CARGO_PROFILE_RELEASE_PANIC=abort \
	CARGO_TARGET_WASM32_UNKNOWN_EMSCRIPTEN_LINKER="./emcc.sh" \
	cargo b --release --target wasm32-unknown-emscripten

build-web-docker:
	docker run -it -v $(shell pwd):/logic rust_emcc /bin/bash -lc "cd /logic && make fix-emc && make build-web"