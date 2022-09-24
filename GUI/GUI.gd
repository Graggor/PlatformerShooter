extends CanvasLayer

onready var player_health_bar = $PlayerHealthBar

func _timer_changed(amount):
	$Label.text = "Timer: " + str(amount)

func _on_player_health_changed(amount):
	player_health_bar.value = amount

func _on_player_max_health_changed(amount):
	player_health_bar.max_value = amount
