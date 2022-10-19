extends Node2D

export var health = 1000
export var boss_name = "The Evil Eye"

signal boss_health_changed
signal boss_max_health_changed
signal boss_appeared
signal boss_died


var floaty_text_scene = preload("res://Characters/FloatingText.tscn")
var attacks = ["laser_left", "laser_right"]
onready var state_machine = $AnimationTree["parameters/playback"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	var gui = get_node("/root/GameManager/GUI")
	connect("boss_health_changed", gui, "_on_boss_health_changed")
	connect("boss_max_health_changed", gui, "_on_boss_max_health_changed")
	connect("boss_appeared", gui, "_on_boss_appeared")
	connect("boss_died", gui, "_on_boss_disappeared")
	emit_signal("boss_max_health_changed", health)
	emit_signal("boss_health_changed", health)
	


func take_damage(amount):
	if health <= 0:
		state_machine.travel("death")
		emit_signal("boss_died")
		return
	
	health -= amount
	emit_signal("boss_health_changed", health)
	var floaty_text = floaty_text_scene.instance()
	floaty_text.global_position = global_position + Vector2(0, -30)
	floaty_text.max_scale = 2
	floaty_text.velocity = Vector2(rand_range(-50, 50), -100)
	floaty_text.modulate = Color(rand_range(0.7, 1), rand_range(0.7, 1), rand_range(0.7, 1), 1.0)
	
	floaty_text.text = amount
	add_child(floaty_text)
	


func _on_Timer_timeout():
	#randomize()
	#var attack_number = randi()%2
	#state_machine.travel(attacks[attack_number])
	state_machine.travel("SuperAttack")
	
