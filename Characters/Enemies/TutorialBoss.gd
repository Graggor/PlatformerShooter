extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Invisible")
	
	




func _on_Door_isClosed():
	$AnimationPlayer.play("Appears") 
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Idle")
	
	
