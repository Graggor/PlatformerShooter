extends TextureProgress

onready var label = $Label

func set_boss_name(name):
	label.text = name
