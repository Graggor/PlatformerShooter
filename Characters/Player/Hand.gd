extends Node2D

var current_weapon
var current_weapon_index = 0

var weapons: Array = []


func _ready():
	weapons = get_children()
	current_weapon = weapons[current_weapon_index]
	for weapon in weapons:
		weapon.hide()
	current_weapon.show()

func get_current_weapon():
	return current_weapon

func reload():
	current_weapon.start_reloading()

func switch_weapon(weapon: Gun):
	if weapon == current_weapon:
		return
	current_weapon.hide()
	weapon.show()
	current_weapon = weapon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if current_weapon.full_automatic:
		if Input.is_action_pressed("shoot"):
			current_weapon._shoot()
	else:
		if Input.is_action_just_pressed("shoot"):
			current_weapon._shoot()
	if Input.is_action_just_pressed("reload"):
		reload()
	if Input.is_action_just_pressed("next weapon"):
		current_weapon_index = (current_weapon_index + 1) % weapons.size()
		switch_weapon(weapons[current_weapon_index])
