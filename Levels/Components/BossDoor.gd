extends StaticBody2D

func _on_Trigger_PlayerEntered():
	$AnimationPlayer.play("Active")
	yield(get_tree().create_timer(1.3), "timeout")
	$AnimationPlayer.play("Closed")
	emit_signal("isClosed")
