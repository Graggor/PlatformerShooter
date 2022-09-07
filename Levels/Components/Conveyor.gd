extends StaticBody2D

export var speed = 100
onready var sprite = $Sprite
var conveyor_texture = preload("res://Sprites/World/Tiles/crosstile.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	var shape_size = $CollisionShape2D.get_shape().get_extents()
	print(shape_size)
	constant_linear_velocity.x = speed
	sprite.texture = AtlasTexture.new()
	sprite.texture.set_atlas(conveyor_texture)
	sprite.texture.set_region(Rect2(0,0,shape_size.x*2,shape_size.y*2))
	
func _physics_process(delta):
	sprite.texture.region.position.x -= speed * delta
