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

# 
clean-web:
	rm target/wasm32-unknown-emscripten/release/logic.wasm || true
	rm target/wasm32-unknown-emscripten/release/deps/logic.wasm || true
	rm target/wasm32-unknown-emscripten/release/deps/logic.wasm.map || true

# single command to quick iteration
rebuild-web: clean-web build-web

build-web:
	RUSTFLAGS="-C link-args=-fPIC -C relocation-model=pic -C target-feature=+mutable-globals" \
	EMMAKEN_CFLAGS="-O1 -s STRICT=1 -s SIDE_MODULE=1" \
	C_INCLUDE_PATH="$(EMSDK)/upstream/emscripten/cache/sysroot/include/" \
	EMCC_STRICT=1 \
	CARGO_PROFILE_RELEASE_PANIC=abort \
	CARGO_TARGET_WASM32_UNKNOWN_EMSCRIPTEN_LINKER="./emcc.sh" \
	cargo b --release --target wasm32-unknown-emscripten
	exa -la target/wasm32-unknown-emscripten/release/logic.wasm
	wasm-validate target/wasm32-unknown-emscripten/release/logic.wasm

build-web-docker:
	docker run -it -v $(shell pwd):/logic rust_emcc /bin/bash -lc "cd /logic && make fix-emc && make build-web"

# prints rust and llvm specific features we can use for emscripten compilation
help-emcc:
	rustc --target wasm32-unknown-emscripten --print target-features