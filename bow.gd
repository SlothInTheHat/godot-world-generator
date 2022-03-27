extends Node2D
onready var animationPlayer = $AnimationPlayer

export var arrowSpeed = 100

signal state
var ready = false
var held = false
var can_shoot = false
var arrow = preload("res://arrow.tscn")
func _process(delta):
	look_at(get_global_mouse_position())
	if ready == false and can_shoot == true:
		if Input.is_action_pressed("attack"):
			held = true
			if held == true:
				animationPlayer.play("bow_draw")
		if Input.is_action_just_released("attack"):
			held = false
			animationPlayer.stop()
	elif ready == true:
		if Input.is_action_just_released("attack"):
			animationPlayer.play(("bow_release"))
			ready = false
func bow_drawn():
		animationPlayer.stop()
		ready = true

func shoot():
	var arrow_instance = arrow.instance()
	arrow_instance.position = $ArrowPoint.get_global_position()
	arrow_instance.rotation_degrees = rotation_degrees
	arrow_instance.apply_impulse(Vector2(), Vector2(arrowSpeed, 0).rotated(rotation))
	get_tree().get_root().add_child(arrow_instance)
	emit_signal("state")
	
