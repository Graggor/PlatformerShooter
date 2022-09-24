extends Node2D

export (NodePath) var lever

func _ready():
	get_node(lever).connect("lever_used", self, "_on_lever_used")

func _open_gate():
	$AnimationPlayer.play("Open")

func _close_gate():
	$AnimationPlayer.play_backwards("Open")

func _on_lever_used(open: bool):
	if open:
		_open_gate()
	else:
		_close_gate()
