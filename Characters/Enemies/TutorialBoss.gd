extends KinematicBody2D

var Ball = preload("res://Items/Weapons/TutorialBossBall.tscn")
onready var attack_timer = $AttackTimer
onready var attack_cooldown = $AttackCooldown

var can_attack = false
var attack_phase = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Invisible")

func _physics_process(delta):
	if can_attack:
		_shoot()

func _on_Door_isClosed():
	$AnimationPlayer.play("Appears") 
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("Idle")
	$AttackTimer.start()

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
