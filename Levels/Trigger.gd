extends Area2D

signal PlayerEntered

export (NodePath) var door
export (NodePath) var boss

var activated = false

func _ready():
	connect("PlayerEntered", get_node(door), "_on_Trigger_PlayerEntered")
	connect("PlayerEntered", get_node(boss), "_on_Door_isClosed")

func _on_BossDoorTrigger_body_entered(body):
	if body.name == "Player" && !activated:
		activated = true
		emit_signal("PlayerEntered")
