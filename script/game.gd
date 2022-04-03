extends Node2D

onready var light_node = get_node("/root/root/light")
onready var light_mask_viewport = get_node("/root/root/light_mask_viewport")

func _ready():
	light_node.texture = light_mask_viewport.get_texture()
	get_node("light").visible = true
