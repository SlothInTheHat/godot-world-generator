extends KinematicBody2D

func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("shake")

func _on_Area2D_body_exited(body):
	$AnimationPlayer.play("shake")



func _on_Area2D2_body_entered(body):
	queue_free()
