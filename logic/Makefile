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