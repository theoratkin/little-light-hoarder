extends Area2D

export(bool) var is_exit = false

onready var light_mask_prefab = load("res://prefab/light_mask.tscn")
onready var light_mask_exit_prefab = load("res://prefab/light_mask.tscn")
onready var light_mask_viewport = get_node("/root/root/light_mask_viewport")
onready var light_node = get_node("/root/root/light")

var light_mask_node

func _ready():
	if visible:
		light_up()

func light_up():
	if not is_exit:
		light_mask_node = light_mask_prefab.instance()
	else:
		light_mask_node = light_mask_exit_prefab.instance()
	light_mask_viewport.add_child(light_mask_node)
	light_mask_node.global_position = global_position

func _on_light_body_entered(_body):
	get_node("/root/root").on_light_collect()
	light_mask_node.queue_free()
	$shape.queue_free()
	$sprite.queue_free()
	$particles.queue_free()
	$sound.play()
