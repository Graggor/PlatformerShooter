class_name Enemy
extends KinematicBody2D

export var detection_radius = 140
export var patrols = false
export var chases = false
export var health = 100

var floaty_text_scene = preload("res://Characters/FloatingText.tscn")

enum States {IDLE, PATROL, ALERT, FIGHT, CHASE, DEAD}
var state_names = ["Idle", "Patrol", "Alert", "Fight", "Chase", "Dead"]
var current_state = States.IDLE

var velocity = Vector2()
var gravity = 200

var player_detected = false
var player = null
var player_last_position = Vector2.ZERO

var weapon
onready var shot_timer = $ShotTimer
onready var emote = $Emote

var can_shoot = true
var has_to_reload = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Body/LedgeDetector.add_exception(self)
	$DetectionSphere/CollisionShape2D.shape.radius = detection_radius
	weapon = $Body/Hand.get_child(0)
	weapon.connect("ammo_changed", self, "_on_ammo_changed")

# TODO: DOESNT MOVE PROPERLY ON CONVEYOR, CLAMP MOVEMENT SPEED SO VELOCITY.X DOESNT HAVE TO BE 0 AT START HERE.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity.x = 0
	velocity.y += gravity*delta
	
	if health <= 0:
		current_state = States.DEAD
	
	match(current_state):
		States.DEAD: _dead_state()
		States.IDLE: _idle_state()
		States.PATROL: _patrol_state()
		States.ALERT: _alert_state()
		States.FIGHT: _fight_state()
		States.CHASE: _chase_state()
	$Label.text = state_names[current_state]
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP, true)

func take_damage(amount):
	print(amount)
	health -= amount
	
	var floaty_text = floaty_text_scene.instance()
	floaty_text.global_position = global_position + Vector2(0, -30)
	floaty_text.velocity = Vector2(rand_range(-50, 50), -100)
	floaty_text.modulate = Color(rand_range(0.7, 1), rand_range(0.7, 1), rand_range(0.7, 1), 1.0)
	
	floaty_text.text = amount
	add_child(floaty_text)

func _idle_state():
	emote._stop_emote()
	if patrols:
		current_state = States.PATROL
		return
	if _player_visible():
		current_state = States.FIGHT
		return

func _patrol_state():
	if $Body.scale.x == 1:
		velocity.x += 2*32
	else:
		velocity.x -= 2*32
	if _check_ledge_and_wall():
		$Body.scale.x = -$Body.scale.x
	if _player_visible() and !_is_behind(player.position):
		current_state = States.FIGHT

# Checks if the target position is behind us, relative to where we're facing
func _is_behind(target_position):
	return ($Body.scale.x == 1 and target_position.x < position.x) or ($Body.scale.x == -1 and target_position.x > position.x)

# Checks if the player is visible. Player is visible if:
# Player has been detected in radius and we have a reference
# 
func _player_visible():
	if player_detected and player != null:
		$PlayerVisibility.cast_to = global_position.direction_to(player.global_position) * detection_radius
		if($PlayerVisibility.get_collider() == player):
			return true
	return false

func _alert_state():
	pass

func _fight_state():
	if player == null:
		current_state = States.CHASE
		return
	if !_player_visible():
		player_last_position = player.position
		current_state = States.CHASE
		return
	$Body/Hand.look_at(player.position)
	if player.position.x < position.x:
		$Body.scale.x = -1
	else:
		$Body.scale.x = 1
	if can_shoot and !has_to_reload:
		can_shoot = false
		weapon._shoot()
		shot_timer.start()

func _chase_state():
	emote._play_emote("question", 100)
	if player_last_position == Vector2.ZERO or !chases:
		current_state = States.IDLE
		return
	if (int(position.x) in range(int(player_last_position.x)-4, int(player_last_position.x)+4)):
		current_state = States.IDLE
		return
	if player_detected and _player_visible():
		current_state = States.IDLE
		return
	if player_last_position.x > position.x:
		velocity.x += 3*32
	else:
		velocity.x -= 3*32

func _dead_state():
	print("im dead")
	$AnimationPlayer.play("dead")
	set_physics_process(false)
	set_process(false)

func _check_ledge_and_wall():
	return !$Body/LedgeDetector.is_colliding()

func _on_DetectionSphere_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_detected = true

func _on_DetectionSphere_body_exited(body):
	if body.is_in_group("player"):
		player_last_position = player.position
		player = null
		player_detected = false

func _on_ammo_changed(amount):
	if amount == 0:
		has_to_reload = true
		yield(get_tree().create_timer(1), "timeout")
		weapon.start_reloading()
	else:
		has_to_reload = false

func _on_ShotTimer_timeout():
	can_shoot = true

func die():
	pass
