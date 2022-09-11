extends RayCast2D

var is_casting := false setget set_is_casting


func _ready() -> void:
	set_physics_process(false)
	$Line2d.points[1] = Vector2.ZERO
	
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
	self.is_casting = event.pressed
	
	
	func _physics_process(delta: float) -> void:
	var cast_point := cast_to
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_points())
		
		$Line2d.points[1] = cast_points
		
	
	func set_is_casting(cast: bool) -> void:
		is casting = cast
	
		if is_casting:
			appear()
		else:
			disappear()
		set_physics_process(is_casting)
		
		
		func appear() -> void:
			$Tween.stop_all()
			$Tween.interpolate_property($Line2d, "width", 0, 10.0, 0.2)
			$Tween.start()
			
			
		func dissapear() -> void:
			$Tween.stop_all()
			$Tween.interpolate_property($Line2d, "width", 0, 10.0, 0.2)
			$Tween.start()
	
	
	
	
	
	
	
	
	
	
	
	
