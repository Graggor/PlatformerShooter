extends StaticBody2D



func _on_Trigger_PlayerEntered():
	$AnimationPlayer.play("Active")
	yield(get_tree().create_timer(1.3), "timeout")
	$AnimationPlayer.play("Closed")


func _on_TutorialBoss_boss_died():
	$AnimationPlayer.play("idle")

func _on_EyeBoss_boss_died():
	 $AnimationPlayer.play("idle")
	
	
func _on_Level2Boss_boss_died():
	 $AnimationPlayer.play("idle")
	

func _on_Level3Boss_boss_died():
	$AnimationPlayer.play("idle")


func _on_Level4Boss_boss_died():
	$AnimationPlayer.play("idle")


func _on_Level_5_boss_boss_died():
	$AnimationPlayer.play("idle")


func _on_level6boss_boss_died():
	$AnimationPlayer.play("idle")
	
	
