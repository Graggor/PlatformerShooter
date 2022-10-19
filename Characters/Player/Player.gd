extends KinematicBody2D

var unit_size = 32

var velocity = Vector2()
var speed = 7 * unit_size
var gravity
var max_jump_velocity
var min_jump_velocity
var is_grounded
var is_jumping = false

var wallJump = 150
var jumpWall = 200

var max_jump_height = 3.25 * unit_size
var min_jump_height = 0.8 * unit_size
var jump_duration = 0.3

var snap = Vector2.ZERO

onready var body = $Body
var floaty_text_scene = preload("res://Characters/FloatingText.tscn")

export var max_health = 200
var health

signal player_died
signal player_health_changed
signal player_max_health_changed

func _ready():
	health = max_health
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)
	var gui = get_node("/root/GameManager/GUI")
	connect("player_health_changed", gui, "_on_player_health_changed")
	connect("player_max_health_changed", gui, "_on_player_max_health_changed")
	emit_signal("player_max_health_changed", health)
	emit_signal("player_health_changed", health)

func _physics_process(delta):
	get_input(delta)
	if !is_on_floor():
		velocity.y += gravity*delta
	
	snap = Vector2.DOWN * 16 if !is_jumping else Vector2.ZERO
	
	if is_on_floor() or nextToWall():
		## If you're on the floor, you're not jumping!
		is_jumping = false
		if Input.is_action_just_pressed("jump"):
			if not is_on_floor() and nextToRightWall():
				velocity.x -= speed
				velocity.y -= jumpWall
			if not is_on_floor() and nextToLeftWall():
				velocity.x += speed
				velocity.y -= jumpWall
			## Dropdown platform code
			if Input.is_action_pressed("down"):
				position.y += 1
				return
			## Jumping if not dropping down
			is_jumping = true
			velocity.y = max_jump_velocity
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP, true)
	$Body/Hand.look_at(get_global_mouse_position())
	
	if get_global_mouse_position().x < global_position.x:
		body.scale.x = -1
	else:
		body.scale.x = 1
	
func get_input(delta):
	# Did a small rework of movement code, have to put it in the right places for it to be cleaner but it works for now.
	# If in the air you're not as mobile anymore with movement. This is to prevent walljumping from being OP.
	# Also applies some drag when on floor instead of setting velocity to 0 so you get pushed away from wall.
	
	#velocity.x = 0
	#if Input.is_action_pressed("move_right"):
	#	velocity.x += speed
	#elif Input.is_action_pressed("move_left"):
	#	velocity.x -= speed
	#velocity.x = clamp(velocity.x, -speed, speed)
	var movement_x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if movement_x != 0:
		velocity.x += movement_x * ((speed * 2) if is_on_floor() else (speed * 0.06))
		velocity.x = clamp(velocity.x, -speed, speed)
	if is_on_floor():
		if movement_x == 0:
			velocity.x = lerp(velocity.x, 0, 1)

func take_damage(amount):
	health -= amount
	var floaty_text = floaty_text_scene.instance()
	floaty_text.global_position = global_position + Vector2(0, -30)
	floaty_text.velocity = Vector2(rand_range(-50, 50), -100)
	floaty_text.modulate = Color(rand_range(0.7, 1), rand_range(0.7, 1), rand_range(0.7, 1), 1.0)
	
	floaty_text.text = amount
	add_child(floaty_text)
	emit_signal("player_health_changed", health)
	if health <= 0:
		die()

func die():
	emit_signal("player_died")
	set_process(false)

func respawn():
	set_process(true)
	health = max_health
	emit_signal("player_max_health_changed", health)
	emit_signal("player_health_changed", health)

func nextToWall():
	return nextToRightWall() or nextToLeftWall()
	
func nextToRightWall():
	return $RightWall.is_colliding()
	
func nextToLeftWall():
	return $LeftWall.is_colliding()
	
	
	
