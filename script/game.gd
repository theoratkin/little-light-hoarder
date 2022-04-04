extends Node2D

onready var light_node = get_node("/root/root/light")
onready var light_mask_viewport = get_node("/root/root/light_mask_viewport")

onready var player = get_node("player")

var player_start_pos

var current_scene = null

var lights_collected = 0

func _ready():
	player_start_pos = player.position
	light_node.texture = light_mask_viewport.get_texture()
	get_node("light").visible = true
	current_scene = get_node("level")


func on_light_collect():
	lights_collected += 1


func load_scene(scene_name):
	# clearing viewport lights
	for n in light_mask_viewport.get_children():
		light_mask_viewport.remove_child(n)
		n.queue_free()
	if current_scene:
		remove_child(current_scene)
		current_scene.queue_free()
	player.position = player_start_pos
	player.ignore_teleport = true
	var scene = load("res://scene/" + scene_name + ".tscn").instance()
	add_child(scene)
	current_scene = scene
