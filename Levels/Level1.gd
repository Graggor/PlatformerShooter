extends Node2D

var checkpoints

# Called when the node enters the scene tree for the first time.
func _ready():
	checkpoints = $CheckPoints.get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
