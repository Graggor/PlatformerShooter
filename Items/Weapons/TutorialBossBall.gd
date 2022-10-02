extends HitBox

var bullet_owner
var speed = 400

func _ready():
	owner = bullet_owner

func _process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body):
	if body.is_in_group("environment"):
		queue_free()

func done_damage():
	queue_free()
