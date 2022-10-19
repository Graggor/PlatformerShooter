extends Node2D


export var health = 500
export var boss_name = "Squarebomb"

onready var _anim_tree = $AnimationTree
onready var attack_timer = $AttackTimer
onready var attack_cooldown = $AttackCooldown

signal boss_health_changed
signal boss_max_health_changed
signal boss_appeared
signal boss_died

var floaty_text_scene = preload("res://Characters/FloatingText.tscn")
var _idle_count = 0
var _hurt_count = 0
var _attack_set = SLIDE
var Ball = preload("res://Items/Weapons/TutorialBossBall.tscn")
var can_attack = false
var attack_phase = false
var ATTACK_THRESHOLD = 1
var DAMAGE_THRESHOLD = 70
var SUPER_THRESHOLD = 0.3 * health

const SQUASH = "SquashAttack"
const SLIDE= "Slideattack"
const SUPER = "attack"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$AnimationTree.active = true
	var gui = get_node("/root/GameManager/GUI")
	connect("boss_health_changed", gui, "_on_boss_health_changed")
	connect("boss_max_health_changed", gui, "_on_boss_max_health_changed")
	connect("boss_appeared", gui, "_on_boss_appeared")
	connect("boss_died", gui, "_on_boss_disappeared")
	emit_signal("boss_max_health_changed", health)
	emit_signal("boss_health_changed", health)
	

func _physics_process(delta):
	if can_attack:
		_shoot()

func _on_Door_isClosed():
	emit_signal("boss_appeared", boss_name)
	_anim_tree.set_condition("Setup", true )

func _start_shooting():
	can_attack = true
	attack_phase = true

func _stop_shooting():
	$AttackCooldown.stop()
	can_attack = false
	attack_phase = false
	$AttackTimer.start()
	$AnimationPlayer.play("Idle")

func _shoot():
	var b = Ball.instance()
	b.set_as_toplevel(true)
	b.bullet_owner = self
	b.transform = $Position2D.global_transform
	add_child(b)
	can_attack = false
	$AttackCooldown.start()

func _on_AttackTimer_timeout():
	$AnimationPlayer.play("attack")

func _on_AttackCooldown_timeout():
	if attack_phase:
		can_attack = true

func take_damage(amount):
	if health <= 0:
		_reset_attack()
		_anim_tree.set_condition("death" , true )
		emit_signal("boss_died")
		return

	health -= amount
	_hurt_count += amount
	emit_signal("boss_health_changed", health)
	var floaty_text = floaty_text_scene.instance()
	floaty_text.global_position = global_position + Vector2(0, -30)
	floaty_text.max_scale = 2
	floaty_text.velocity = Vector2(rand_range(-50, 50), -100)
	floaty_text.modulate = Color(rand_range(0.7, 1), rand_range(0.7, 1), rand_range(0.7, 1), 1.0)
	
	floaty_text.text = amount
	add_child(floaty_text)
	
func increase_idle_count():
	_idle_count += 1
	
	if _idle_count > ATTACK_THRESHOLD:
		_idle_count = 0
		attack()

func attack():
		_attack_set = SLIDE
		if _hurt_count > DAMAGE_THRESHOLD:
			_hurt_count = 0
			_attack_set = SQUASH
		if health <= SUPER_THRESHOLD:
			_attack_set = SUPER
		_anim_tree.set_condition(_attack_set, true)

func _reset_attack():
	_anim_tree.set_condition("attack" , false )
	_anim_tree.set_condition("Slideattack" , false )

func _reset_move():
	_anim_tree.set_condition("SquashAttack" , false )
