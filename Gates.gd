extends Node2D

export var code = "0"
var codeFromLevers = ""
var levers =[]


func _ready():
	levers = get_node("Levers").get_children()
# warning-ignore:return_value_discarded
	GateSignal.connect("LeverChanged",self,"CheckCode")
	for lever in levers:
		print (lever.name," " , lever.state)

func CheckCode():
# warning-ignore:shadowed_variable
	var codeFromLevers = ""
	for lever in levers:
		codeFromLevers += lever.state
	
	if code == codeFromLevers:
		$StaticBody2D/CollisionShape2D.disabled = true
		$AnimationPlayer.play("Closed")
	else:
		$StaticBody2D/CollisionShape2D.disabled = false
		$AnimationPlayer.play("Opened")
