extends Node

signal level_completed

func _ready():
	connect("level_completed", Globals, "_on_level_complete")

func _on_OpenDoorZone_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("Open")

func _on_NextLevelZone_body_entered(body):
	if body.name == "Player":
		emit_signal("level_completed")
		get_tree().change_scene("res://Levels/Inbetween.tscn")
