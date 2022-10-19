extends Area2D

onready var area2D = $Area2D
signal PlayerEntered


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("Flashing")
	emit_signal("PlayerEntered")
	
	

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		$AnimationPlayer.play("Off")
	emit_signal("PlayerEntered")
