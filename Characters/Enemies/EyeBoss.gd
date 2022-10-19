extends Node2D

export var health = 1000

var floaty_text_scene = preload("res://Characters/FloatingText.tscn")

var attacks = ["laser_left", "laser_right"]

onready var state_machine = $AnimationTree["parameters/playback"]


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func take_damage(amount):
	health -= amount
	
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
	
