extends Area2D

var opened = false

func _on_BreakingPlatform_body_entered(body):
	if body.name == "Player" and !opened:
			opened = true
			$AnimationPlayer.play("Destroyed")
			$RespawnTimer.start()

func _on_RespawnTimer_timeout():
	opened = false
	$AnimationPlayer.play_backwards("Destroyed")
