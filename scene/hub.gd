extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var lights = get_node("/root/root").lights_collected
	if lights > 5:
		turn_lights_on(1)


func turn_lights_on(part):
	for n in get_node("lights/p" + str(part)).get_children():
		n.visible = true;
		n.light_up()
	if part == 5:
		get_node("lights/thanks").visible = true
