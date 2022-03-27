extends KinematicBody2D



export var ACCELERATION = 300
export var MAX_SPEED = 25
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

onready var sprite = $Sprite
onready var stats = $Stats
onready var Player_Detection_Zone = $PlayerDetectionZone
onready var hurtbox = $Hurtbox
onready var animation = $AnimationPlayer
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	knockback = move_and_slide(knockback)
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	
	match state:
		IDLE:
			animation.play("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()
		WANDER:
			animation.play("Walk")
			seek_player()
			if wanderController.get_time_left() == 0:
				update_wander()
				
			accelerate_towards_point(wanderController.target_position, delta)
			
			
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
				
		CHASE:
			animation.play("Walk")
			var player = Player_Detection_Zone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
	
			
			
			if softCollision.is_colliding():
				velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x<0
	
func seek_player():
	if Player_Detection_Zone.can_see_player():
		state = CHASE
		
func update_wander():
	state = pick_random_state([IDLE, WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector* -100
	hurtbox.create_hit_effect(true)
	var angle = get_angle_to(area.position)
	velocity = Vector2(cos(angle), sin(angle))*-10000

func _on_Stats_no_health():
	queue_free()
