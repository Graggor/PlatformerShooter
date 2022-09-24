extends Node2D

onready var area2D = $Area2D
var activated = false
var player_present = false

signal lever_used

func _ready():
	$AnimationPlayer.play("Idle")

func _process(_delta):
	if Input.is_action_just_pressed("use"):
		if player_present:
			$AnimationPlayer.clear_queue()
			if !activated:
				activated = true
				$AnimationPlayer.play("Active")
				$AnimationPlayer.queue("IdleActive")
			else:
				activated = false
				$AnimationPlayer.play("Active")
				$AnimationPlayer.queue("Idle")
			emit_signal("lever_used", activated)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player_present = true

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		player_present = false
