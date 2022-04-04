extends Node2D

onready var light_node = get_node("/root/root/light")
onready var light_mask_viewport = get_node("/root/root/light_mask_viewport")

onready var player = get_node("player")

var player_start_pos

var current_scene = null
var current_scene_name = "hub"

var total_lights = 48
var current_scene_lights = 0
var lights_collected = {"hub" : 0}

func _ready():
	player_start_pos = player.position
	light_node.texture = light_mask_viewport.get_texture()
	get_node("light").visible = true
	current_scene = get_node("hub")


func on_light_collect():
	current_scene_lights += 1
	lights_collected[current_scene_name] = max(lights_collected[current_scene_name], current_scene_lights)
	get_node("gui/count/text").text = "%d/%d" % [get_lights_count(), total_lights]


func get_lights_count():
	var sum = 0
	for val in lights_collected.values():
		sum += val
	return sum


func load_scene(scene_name):
	if not scene_name in lights_collected:
		lights_collected[scene_name] = 0
	current_scene_lights = 0
	current_scene_name = scene_name
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
