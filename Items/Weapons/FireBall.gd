extends HitBox

export (NodePath) var boss

# Called when the node enters the scene tree for the first time.
func _ready():
	owner = boss

func _set_enabled():
	$CollisionShape2D.disabled = false
	$Particles2D.emitting = true

func _set_disabled():
	$CollisionShape2D.disabled = true
	$Particles2D.emitting = false
