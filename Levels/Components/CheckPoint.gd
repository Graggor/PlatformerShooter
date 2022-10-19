extends Area2D

var reached = false
signal reached

func _on_CheckPoint_body_entered(body):
	if body.is_in_group("player"):
		reached = true
		$AnimationPlayer.play("reached")
		emit_signal("reached", self)
