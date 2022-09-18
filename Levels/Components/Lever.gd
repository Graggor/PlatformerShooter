extends Node2D

signal Is_Active

func _physics_process(delta):
	var bodies = $Area2d.get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			$AnimationPlayer.play("Active")
			yield($AnimationPlayer, "animation_finished")
			$AnimationPlayer.play("IdleActive")
			emit_signal("Is_Active")
		else:
			$AnimationPlayer.play("Idle")
			
		
