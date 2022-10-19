extends Area2D

signal PlayerEntered



func _on_ToNextLevelTrigger_body_entered(body):
	if body.name == "Player" :
		$Camera2D.current = true
		emit_signal("PlayerEntered")
		
		
