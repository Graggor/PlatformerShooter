extends Area2D

var opened = false

func _physics_process(_delta):
	 var bodies = get_overlapping_bodies()
	 for body in bodies:
			if body.name == "Player" and !opened:
				opened = true
				$AnimationPlayer.play("RoomRevealed")
				yield($AnimationPlayer, "animation_finished")
			#else:
				#$AnimationPlayer.play("RoomHidden")
