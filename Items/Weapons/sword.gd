extends Node2D

func _process(delta):
	if is_visible():
		enable()
	else:
		disable()

func set_owner(new_owner):
	$HitBox.owner = new_owner

func enable():
	$HitBox/CollisionShape2D.disabled = false

func disable():
	$HitBox/CollisionShape2D.disabled = true
