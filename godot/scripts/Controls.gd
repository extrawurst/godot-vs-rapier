extends Node2D

var box = null;
var count=0;

func _ready():
	box = load("res://scenes/GodotBox.tscn");

func _process(_delta):
	if Input.is_action_pressed("click"):
		var pos = get_global_mouse_position();
		var newbox = box.instance();
		newbox.position = pos;
		add_child(newbox);
		count+=1;
		get_node("../Label").text = String(count);
