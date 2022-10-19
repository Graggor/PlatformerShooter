extends Area2D

signal PlayerEntered

export (NodePath) var door
export (NodePath) var door1
export (NodePath) var boss


var activated = false

func _ready():
	connect("PlayerEntered", get_node(door), "_on_Trigger_PlayerEntered")
	connect("PlayerEntered", get_node(boss), "_on_Door_isClosed")
	connect("PlayerEntered", get_node(door1),"_on_Trigger_PlayerEntered")

func _on_BossDoorTrigger_body_entered(body):
	if body.name == "Player" && !activated:
		$Camera2D.current = true
		activated = true
		emit_signal("PlayerEntered")
		

