extends CanvasLayer

onready var player_health_bar = $PlayerHealthBar
onready var boss_health_bar = $BossHealthbar

func _timer_changed(amount):
	$Label.text = "Timer: " + str(amount)

func _on_player_health_changed(amount):
	player_health_bar.value = amount

func _on_player_max_health_changed(amount):
	player_health_bar.max_value = amount

func _on_boss_health_changed(amount):
	boss_health_bar.value = amount

func _on_boss_max_health_changed(amount):
	boss_health_bar.max_value = amount

func _on_boss_appeared(name):
	boss_health_bar.set_boss_name(name)
	boss_health_bar.visible = true

func _on_boss_disappeared():
	boss_health_bar.visible = false
