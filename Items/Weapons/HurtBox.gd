class_name HurtBox
extends Area2D

# A HurtBox attaches to something that can be hurt, like a player

func _init():
	pass

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _on_area_entered(hitbox: HitBox):
	if hitbox == null:
		return
		
	if (hitbox.owner != owner) && owner.has_method("take_damage"):
		print(hitbox.owner)
		print(owner)
		owner.take_damage(hitbox.damage)
	
	hitbox.done_damage()
