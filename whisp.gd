extends KinematicBody2D
onready var wanderController = $WanderController

export var ACCELERATION = 500
export var MAX_SPEED = 50
export var FRICTION = 20
export var WANDER_TARGET_RANGE = 4
var velocity = Vector2.ZERO

func _ready():
	$YSort/Sprite/Particles2D.emitting = true

func _physics_process(delta):
	$YSort/Sprite.rotation += 0.15
	if wanderController.get_time_left() == 0:
		update_wander()
		accelerate_towards_point(wanderController.target_position, delta)
	if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
		update_wander()
	velocity = move_and_slide(velocity)
	
func update_wander():
	wanderController.start_wander_timer(rand_range(1, 3))
	
func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	
