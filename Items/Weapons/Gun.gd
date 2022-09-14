extends Node2D
class_name Gun

var Bullet = preload("res://Items/Weapons/Bullet.tscn")
var can_shoot = true
onready var audio = $AudioStreamPlayer2D
onready var muzzleplayer = $MuzzlePlayer
onready var gunplayer = $GunPlayer
onready var shoottimer = $ShootTimer
export var shooting_cooldown = 0.2

var shooter = null

export var full_automatic = false
var ammunition
export var max_ammunition = 5
export var audio_pitch = 1.0
var is_reloading = false

signal ammo_changed

func _ready():
	ammunition = max_ammunition

func _shoot():
	if is_reloading:
		gunplayer.play("RESET")
		is_reloading = false
	if ammunition == 0:
		return
	if full_automatic:
		if !can_shoot:
			return
		can_shoot = false
		shoottimer.start(shooting_cooldown)
	var b = Bullet.instance()
	b.bullet_owner = owner
	b.set_as_toplevel(true)
	b.transform = $Position2D.global_transform
	add_child(b)
	audio.pitch_scale = audio_pitch
	muzzleplayer.play("muzzle")
	#audio.play()
	ammunition -= 1
	emit_signal("ammo_changed", ammunition)

func start_reloading():
	if !is_reloading:
		is_reloading = true
		$GunPlayer.play("reload")

func finish_reloading():
	is_reloading = false
	ammunition = max_ammunition
	emit_signal("ammo_changed", ammunition)

func _on_ShootTimer_timeout():
	can_shoot = true
