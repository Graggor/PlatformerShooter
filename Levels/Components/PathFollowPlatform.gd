extends Path2D

onready var path_follower = $PathFollow2D

export var speed = 100
export var wait_time = 0.0

var going_forward = true
var is_waiting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	path_follower.set_rotate(false)
	print(self.get_curve().get_baked_length())
	path_follower.rotation_degrees = 0


# Platform starts by moving forward
# If it reaches the end (clamped so it doesn't automatically go to the start again) it reverses
# The same happens when going backwards, when reaching start it reverses again
func _physics_process(delta):
	if is_waiting:
		return
	if going_forward:
		if path_follower.unit_offset >= 1:
			going_forward = false
			start_waiting()
		else:
			path_follower.offset = clamp(path_follower.offset + speed*delta, 0, get_curve().get_baked_length())
	else:
		if path_follower.unit_offset <= 0:
			going_forward = true
			start_waiting()
		else:
			path_follower.offset = clamp(path_follower.offset - speed*delta, 0, get_curve().get_baked_length())
	
func start_waiting():
	if wait_time == 0:
		is_waiting = false
		return
	is_waiting = true
	$WaitTimer.start(wait_time)


func _on_WaitTimer_timeout():
	is_waiting = false
