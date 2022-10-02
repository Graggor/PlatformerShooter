extends Camera2D

var interpolate_val = 2
var MAX_CAMERA_DISTANCE = 40
var CAMERA_SPEED = 0.06

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	var target = owner.global_position 
	#var mid_x = ((target.x + get_global_mouse_position().x) / 2) + 64
	#var mid_y = ((target.y + get_global_mouse_position().y) / 2) + 64
	#camera_position = player.global_position + direction.normalized() * MAX_CAMERA_DISTANCE
	var direction = target.direction_to(get_global_mouse_position())

	#global_position = global_position.linear_interpolate(Vector2(mid_x,mid_y), interpolate_val * delta) 
	var camera_position = target + direction.normalized() * MAX_CAMERA_DISTANCE
	#global_position = target + direction.normalized() * MAX_CAMERA_DISTANCE
	global_position = lerp(global_position, camera_position, CAMERA_SPEED)
