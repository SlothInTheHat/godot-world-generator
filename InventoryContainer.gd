extends Node2D

func _input(event):
	if event.is_action_pressed("E"):
		if visible == true:
			visible = false
		else:
			visible = true



