mod rapier_world;
mod utils;

use gdnative::prelude::*;

fn init(handle: InitHandle) {
    godot_print!("gdnative init");
    handle.add_class::<rapier_world::RapierWorld2D>();
}

fn shutdown(info: &gdnative::TerminateInfo) {
    godot_print!("shutdown: (in_editor: {})", info.in_editor());
}

godot_gdnative_init!();
godot_nativescript_init!(init);
godot_gdnative_terminate!(shutdown);
