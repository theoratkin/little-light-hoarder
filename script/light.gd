extends Area2D

onready var light_mask_prefab = load("res://prefab/light_mask.tscn")
onready var light_mask_viewport = get_node("/root/root/light_mask_viewport")
onready var light_node = get_node("/root/root/light")

var light_mask_node

func _ready():
	light_mask_node = light_mask_prefab.instance()
	light_mask_viewport.add_child(light_mask_node)
	light_mask_node.global_position = global_position

func _on_light_body_entered(body):
	light_mask_node.queue_free()
	queue_free()
