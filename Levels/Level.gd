class_name Level
extends Node2D

var checkpoints
var checkpoints_found = []
var last_checkpoint = null
signal loaded
signal request_fade_to_black
var player_spawn_location

# Called when the node enters the scene tree for the first time.
func _ready():
	checkpoints = $Checkpoints.get_children()
	for checkpoint in checkpoints:
		checkpoint.connect("reached", self, "_on_checkpoint_reached")
	player_spawn_location = get_node("Player").global_position
	get_node("Player").connect("player_died", self, "_on_player_died")

func _on_checkpoint_reached(checkpoint):
	checkpoints_found.push_back(checkpoint)
	last_checkpoint = checkpoint

func _on_player_died():
	emit_signal("request_fade_to_black", true)
	respawn_player()

func respawn_player():
	var respawn_position
	if last_checkpoint == null:
		respawn_position = player_spawn_location
	else:
		respawn_position = last_checkpoint.global_position
	$Player.global_position = respawn_position
	$Player.respawn()
	#emit_signal("request_fade_to_black", false)
