extends KinematicBody2D



export var ACCELERATION = 300
export var MAX_SPEED = 20
export var FRICTION = 400
export var WANDER_TARGET_RANGE = 4



enum {
	IDLE, 
	WANDER, 
	CHASE
}

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

var state = CHASE

onready var body = $body
onready var head = $body/head
onready var stats = $Stats
onready var hurtbox = $Hurtbox
onready var animation = $AnimationPlayer
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	if stats.health > 0:
		if velocity.x >0:
			animation.play("Walk Right")
		elif velocity.x <0:
			animation.play("Walk left")
	knockback = move_and_slide(knockback)
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	
	match state:
		IDLE:
			animation.play("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

			
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			if wanderController.get_time_left() == 0:
				update_wander()
				
			accelerate_towards_point(wanderController.target_position, delta)
			
			
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
				
		CHASE:
			pass
	
			
			
			if softCollision.is_colliding():
				velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	
	
func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	if area.knockback_vector != null:
		knockback = area.knockback_vector* 85
	hurtbox.create_hit_effect(true)
	state = WANDER
	if stats.health <= 0:
		animation.play("dead")

func _on_Stats_no_health():
	queue_free()

func deadAnimationFinished():
	queue_free()
