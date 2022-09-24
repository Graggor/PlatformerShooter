extends Area2D

var opened = false

func _on_BreakingPlatform_body_entered(body):
	if body.name == "Player" and !opened:
			opened = true
			$AnimationPlayer.play("Destroyed")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
	else:
		$AnimationPlayer.play("idle")
