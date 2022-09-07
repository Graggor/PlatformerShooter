extends HitBox

var bullet_owner
var speed = 400

func _process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("killable"):
		if body.has_method("take_damage"):
			body.take_damage()
		queue_free()
	if body.is_in_group("environment"):
		queue_free()
