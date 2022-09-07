extends Node2D

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.hide()

func _play_emote(emote, duration):
	if emote in animation_player.get_animation_list():
		animation_player.play(emote)
		sprite.show()
		timer.start(duration)
	else:
		print("Emote not found!")

func _stop_emote():
	timer.stop()
	sprite.hide()

func _on_Timer_timeout():
	sprite.hide()
