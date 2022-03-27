extends Camera2D

func _process(delta):
	if Input.is_action_just_pressed("1"):
		zoom = Vector2(1.25, 1.25)
	if Input.is_action_just_pressed("2"):
		zoom = Vector2(15, 15)
