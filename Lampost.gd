extends Node

signal PlayerEntered
export var flicker = true

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if flicker:
			$AnimationPlayer.play("Flashing")
		else:
			$AnimationPlayer.play("On")
	emit_signal("PlayerEntered")

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		$AnimationPlayer.play("Off")
