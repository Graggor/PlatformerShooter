extends KinematicBody2D

"""
-Every 2 idle animation the boss attack
-Swordattack by default
-Move every 70 damage take
-superattack  below 50% Health
-Dead when Health depletes
"""""

export var health = 2500

onready var _anim_tree = $AnimationTree


var floaty_text_scene = preload("res://Characters/FloatingText.tscn")
var _idle_count = 0
var _hurt_count = 0
var _attack_set = SWORD



const ATTACK_THRESHOLD = 1
const MOVE_THRESHOLD = 5
const SUPER_THRESHOLD = 0.3 
const MOVE = ["move"]
const SWORD= ["Swordattack"]
const SUPER = ["superattack"]


func take_damage(amount):
	health -= amount
	
	var floaty_text = floaty_text_scene.instance()
	floaty_text.global_position = global_position + Vector2(0, -30)
	floaty_text.max_scale = 2
	floaty_text.velocity = Vector2(rand_range(-50, 50), -100)
	floaty_text.modulate = Color(rand_range(0.7, 1), rand_range(0.7, 1), rand_range(0.7, 1), 1.0)
	
	floaty_text.text = amount
	add_child(floaty_text)

func _ready():
	randomize()
	
	
func increase_idle_count():
	_idle_count += 1
	
	if _idle_count > ATTACK_THRESHOLD:
		_idle_count = 0
		attack()



func attack():
		_attack_set = SWORD
		if _hurt_count > MOVE_THRESHOLD:
			_attack_set = MOVE
		if health.current <= health.current * SUPER_THRESHOLD:
			_attack_set = SUPER
		var attack = _attack_set[randi()%_attack_set.size()]
		_anim_tree.set_condition(attack, true)
		
	
func _on_Health_changed(_new_amount) -> void:
	_hurt_count += 1
	
func _on_Health_depleted() -> void:
	_anim_tree.set_condition("death" , true )
	
func _on_Door_isClosed():
	_anim_tree.set_condition("Setup", true )
	



