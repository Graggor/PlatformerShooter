class_name HurtBox
extends Area2D

func _init():
	pass

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(hitbox: HitBox):
	if hitbox == null:
		return
		
	if (hitbox.owner != owner) && owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
	
	hitbox.done_damage()
