extends RayCast2D

export var laser_width = 10

var is_casting = false setget set_is_casting
export var cast_at_start = false
onready var hitbox = $HitBox

func _ready():
	hitbox.owner = owner
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO
	set_is_casting(cast_at_start)

func _physics_process(delta):
	var cast_point = cast_to
	force_raycast_update()
	
	$CollisionParticles2D.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		$CollisionParticles2D.global_rotation = get_collision_normal().angle()
		$CollisionParticles2D.position = cast_point
		hitbox.position = cast_point
		
	
	$Line2D.points[1] = cast_point

func set_is_casting(cast: bool):
	is_casting = cast
	$HitBox/CollisionShape2D.disabled = !is_casting
	
	$CastingParticles2D.emitting = is_casting
	if is_casting:
		appear()
	else:
		$CollisionParticles2D.emitting = false
		disappear()
	set_physics_process(is_casting)

func appear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, laser_width, 0.2)
	$Tween.start()

func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", laser_width, 0, 0.1)
	$Tween.start()
