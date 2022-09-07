extends Area2D

export var width = 2000

# Called when the node enters the scene tree for the first time.
func _ready():
	var shape = $CollisionShape2D.get_shape()
	shape.extents.x = width


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DeathZone_body_entered(body):
	if body.is_in_group("player"):
		body.die()
