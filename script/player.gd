extends KinematicBody2D

var can_move = true

var snap = false

var run_speed = 50
var jump_speed = 160
var gravity = 400

var ignore_teleport = false

var velocity = Vector2()

var startx

onready var sprite = get_node("sprite")
onready var eyes = get_node("eyes")

var gender

var idle_name = "idle"

const JUMP_BUFFER = 0.3
var _jump_buffer = 0.0

func _ready():
	#eyelids = get_node("eyelids")
	#blink(true)
	align_position_to_pixels()
	startx = position.x
	#set_active(false)


func set_active(state):
	can_move = state
	visible = state


func align_position_to_pixels():
	position = Vector2(round(position.x), position.y)


func flip(state):
	transform.x = Vector2(-1 if state else 1, 0)


func get_input():
	if not can_move:
		velocity.x = 0
		sprite.play(idle_name)
		align_position_to_pixels()
		return
	velocity.x = 0
	var right = Input.is_action_pressed('right')
	var left = Input.is_action_pressed('left')
	var jump = Input.is_action_just_pressed('jump')
	
	if not is_on_floor() and jump:
		_jump_buffer = JUMP_BUFFER
	
	if is_on_floor() and (jump or _jump_buffer > 0):
		velocity.y = -jump_speed
		_jump_buffer = 0
	
	if right:
		flip(false)
		velocity.x += run_speed
	if left:
		flip(true)
		velocity.x -= run_speed
	if !right and !left:
		if is_on_floor():
			sprite.play("idle")
			eyes.play("idle")
		#flip(false)
		align_position_to_pixels()
	
	if !is_on_floor():
		if !right and !left:
			sprite.play("jump")
			eyes.play("jump")


func _physics_process(delta):
	ignore_teleport = false
	velocity.y += gravity * delta
	get_input()
	if not snap:
		velocity = move_and_slide(velocity, Vector2(0, -1))
	else:
		velocity = move_and_slide_with_snap(velocity, Vector2(0, 8), Vector2(0, -1))
	if _jump_buffer > 0:
		_jump_buffer -= delta
