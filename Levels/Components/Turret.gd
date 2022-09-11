extends Node2D

var player = null

onready var turret = $Turret

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if player != null:
		turret.look_at(player.position)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player = body

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player = null
