extends Node

var levels = []
var current_level = 0

func _on_level_complete():
	current_level = current_level + 1
	# travel to inbetween if current_level < aantal levels
	# travel to "finished" screen otherwise
