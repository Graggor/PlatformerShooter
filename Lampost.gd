extends Node

signal PlayerEntered
export var flicker = true
onready var animation_player = $Area2D/AnimationPlayer

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if flicker:
			animation_player.play("Flashing")
		else:
			animation_player.play("On")
	emit_signal("PlayerEntered")

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		animation_player.play("Off")
