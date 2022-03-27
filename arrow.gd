extends RigidBody2D

func _ready():
	$AnimationPlayer.play("arrow")
func _on_arrow_body_entered(body):
	if !body.is_in_group("player"):
		queue_free()
