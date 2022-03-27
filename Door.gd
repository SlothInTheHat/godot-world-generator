extends StaticBody2D

onready var animation = $AnimationPlayer


func _on_Area2D_body_entered(body):
	animation.play("open")


func _on_Area2D_body_exited(body):
	animation.play_backwards("open")
