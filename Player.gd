extends KinematicBody2D

var acceleration = 350
var max_speed = 60
var roll_speed = 100
var friction = 350
var velocity = Vector2.ZERO
var input_vector
var state
var direction = 1
var player_pos = position
onready var right_hand = $body/right_hand
onready var body = $body
onready var legs_animator = $legsAnimator
onready var body_animator = $bodyAnimator

func _ready():
	position = Vector2(3000/10*8, 1000/10*8)
	state = "walk"

func _physics_process(delta):
	if state == "walk":
		input_vector = walk(delta)
	elif state == "roll":
		roll(delta, input_vector)
	face_direction()
	
	

func walk(delta):
	input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("d") - Input.get_action_strength("a")
	input_vector.y = Input.get_action_strength("s") - Input.get_action_strength("w")
	input_vector = input_vector.normalized()
	
	if Input.is_action_just_pressed("roll"):
		state = "roll"
		roll(delta, input_vector)
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	velocity = move_and_slide(velocity)
	
	if state != "roll":
		if velocity != Vector2.ZERO:
			legs_animator.play("walk")
			body_animator.play("walk")
		else:
			legs_animator.play("idle")
			body_animator.play("idle")
	else:
		legs_animator.stop()
		body_animator.stop()
		
	return input_vector

func roll(delta, input_vector):
	velocity = velocity.move_toward(input_vector * roll_speed, acceleration * delta)
	body_animator.play("roll")
	legs_animator.play("roll")
	velocity = move_and_slide(velocity)
	
func roll_end():
	state = "walk"
	velocity = input_vector * max_speed

func face_direction():
	if get_global_mouse_position().x < position.x:
		body.scale = Vector2(-1, 1)
		
	elif get_global_mouse_position().x > position.x:
		body.scale = Vector2(1, 1)
