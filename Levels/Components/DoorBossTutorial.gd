extends StaticBody2D

signal isClosed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Trigger_PlayerEntered():
	$AnimationPlayer.play("Active")
	yield(get_tree().create_timer(1.3), "timeout")
	$AnimationPlayer.play("Closed")
	emit_signal("isClosed")
	
   
