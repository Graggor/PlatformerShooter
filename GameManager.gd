extends Node

export (PackedScene) var first_scene

var time_start = 0
var time_now = 0
onready var level_holder = $Level
onready var fade_rect = $FadeRect
onready var tween = $Tween

export var number_of_levels = 0

signal timer_changed

# Called when the node enters the scene tree for the first time.
func _ready():
	$GUI.hide()
	connect("timer_changed", $GUI, "_timer_changed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_now = OS.get_unix_time()
	var time_elapsed = time_now - time_start
	emit_signal("timer_changed", time_elapsed)

func start_game():
	$MainMenu.hide()
	$GUI.show()
	change_level(first_scene)
	time_start = OS.get_unix_time()

func change_level(scene: PackedScene):
	fade(true)
	#Remove current level
	for level in level_holder.get_children():
		level_holder.remove_child(level)
		level.queue_free()
	#Instance next level
	fade(false)
	yield(tween, "tween_all_completed")
	var next_scene = scene.instance()
	print(next_scene.has_signal("request_fade_to_black"))
	print(next_scene.connect("request_fade_to_black", self, "fade"))
	level_holder.add_child(next_scene)

func fade(to_black = true):
	var fade_duration = 0.5
	if to_black:
		tween.interpolate_property(fade_rect, "modulate:a", 1, 0, fade_duration)
		tween.interpolate_callback(fade_rect, fade_duration, "hide")
		tween.start()
	else:
		fade_rect.show()
		tween.interpolate_property(fade_rect, "modulate:a", 0, 1, fade_duration)
		tween.start()
