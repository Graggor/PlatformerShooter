extends Node

export (PackedScene) var first_scene

var time_start = 0
var time_now = 0

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
	var first_scene_loaded = first_scene.instance()
	$Level.add_child(first_scene_loaded)
	time_start = OS.get_unix_time()
