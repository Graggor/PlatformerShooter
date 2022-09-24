extends Node2D


onready var area2D = $Area2D
export var state = "0"
 

func _ready():
	if state == "0":
		$AnimationPlayer.play("Idle")
	else:
		$AnimationPlayer.play("Idle")
		
		

func process_delta():
	if area2D.overlaps_body($"../../../Player") and Input.is_action_just_pressed("Use"):
		if state == "0":
			state = "1"
		else:
			state = "0"
		GateSignal.LeverChanged()
	if state == "0":
		$AnimationPlayer.play("Active")
	else:
		$AnimationPlayer.play("IdleActive")
	







