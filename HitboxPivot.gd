extends Position2D

var angle = 0
func _process(delta):
	look_at(get_global_mouse_position())
