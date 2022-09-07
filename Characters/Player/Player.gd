extends KinematicBody2D

var unit_size = 32

var velocity = Vector2()
var speed = 7 * unit_size
var gravity
var max_jump_velocity
var min_jump_velocity
var is_grounded
var is_jumping = false

var max_jump_height = 3.25 * unit_size
var min_jump_height = 0.8 * unit_size
var jump_duration = 0.3

var snap = Vector2.ZERO

onready var body = $Body

signal player_died

func _ready():
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)
	$Emote._play_emote("alert", 1)

func _physics_process(delta):
	get_input()
	if !is_on_floor():
		velocity.y += gravity*delta
	snap = Vector2.DOWN * 16 if !is_jumping else Vector2.ZERO
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true)
	if is_on_floor():
		## If you're on the floor, you're not jumping!
		is_jumping = false
		if Input.is_action_just_pressed("jump"):
			## Dropdown platform code
			if Input.is_action_pressed("down"):
				position.y += 1
				return
			## Jumping if not dropping down
			is_jumping = true
			velocity.y = max_jump_velocity
	
	$Body/Hand.look_at(get_global_mouse_position())
	
	if get_global_mouse_position().x < global_position.x:
		body.scale.x = -1
	else:
		body.scale.x = 1
	
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed

func die():
	emit_signal("player_died")
	get_tree().reload_current_scene()
