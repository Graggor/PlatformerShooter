extends Position2D

onready var tween = $Tween

var velocity = Vector2(50, -100)
var gravity = Vector2(0, 1)
var mass = 200
var max_scale = 1.0

# warning-ignore:unused_class_variable
var text setget set_text, get_text

# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_toplevel(true)
	tween.interpolate_property(self, "modulate",
		Color(modulate.r, modulate.g, modulate.b, modulate.a),
		Color(modulate.r, modulate.g, modulate.b, 0.0),
		0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.7)

	tween.interpolate_property(self, "scale",
		Vector2(0, 0),
		Vector2(max_scale, max_scale),
		0.3, Tween.TRANS_QUART, Tween.EASE_OUT)
	
	tween.interpolate_property(self, "scale",
		Vector2(max_scale, max_scale),
		Vector2(0.4, 0.4),
		0.3, Tween.TRANS_QUART, Tween.EASE_OUT)
	
	tween.interpolate_callback(self, 1.0, "queue_free")
	
	tween.start()

func _process(delta):
	velocity += gravity * mass * delta
	position += velocity * delta

func set_text(new_text):
	$Label.text = str(new_text)

func get_text():
	return $Label.text
