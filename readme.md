# Godot vs. Rapier

[Rapier](https://rapier.rs) is an open source physics framework written in Rust.

This project pits godots built-in physics against Rapier. It uses [godot-rust](https://github.com/godot-rust/godot-rust) to integrate rustcode in godot using gdnative.

![demo](demo.gif)

**note**: Godots built-in physics has an open issue for the instability when stacking a lot of rigid bodies: https://github.com/godotengine/godot/issues/2092

## WebGL

finally the webgl export of godot games using gdnative rust works (see the [whole conversation](https://github.com/godot-rust/godot-rust/issues/647))

demo: https://extrawurst.github.io/godot-vs-rapier/
