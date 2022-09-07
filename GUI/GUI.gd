extends CanvasLayer

func _timer_changed(amount):
	$Label.text = "Timer: " + str(amount)
