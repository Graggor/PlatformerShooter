extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_is_casting(cast):
	for child in self.get_children():
		child.set_is_casting(cast)
