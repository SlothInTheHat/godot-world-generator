extends KinematicBody2D

var state = 1
var velocity = Vector2()
var player = Vector2()
var angleToPlayer = null
var speed = 15
var direction = 1
var health = 20
var target_vector = null
func _physics_process(delta):
	if health >0:
		
		if state == 1:
			velocity = Vector2(0,0)
			if direction == 1:
				$AnimationPlayer.play("Idle right")
			elif direction == 0:
				$AnimationPlayer.play("Idle left")
			if $Timer.time_left == 0:
				update_wander()
		
		if state == 2 and target_vector != null:
			if velocity.x>0:
				direction = 1
			elif velocity.x<0:
				direction = 0
			if direction == 1:
				$AnimationPlayer.play("Run right")
			elif direction == 0:
				$AnimationPlayer.play("Run left")
			velocity = position.direction_to(target_vector) * speed
			if $Timer.time_left == 0:
				update_wander()
			if global_position.distance_to(target_vector)<=1:
				update_wander()
		if state == 3 and player != null:
			velocity = position.direction_to(player.position) * speed
			
			if velocity.x>0:
				direction = 1
			elif velocity.x<0:
				direction = 0
			if self.position.distance_to(player.position)<15:
				state = 4
			if direction == 1:
				$AnimationPlayer.play("Run right")
			elif direction == 0:
				$AnimationPlayer.play("Run left")
		if state == 4:
			if player != null:
				if player.position.y<position.y and player.position.x<position.x:
					$Position2D.rotation_degrees = -135
				elif player.position.y<position.y and player.position.x<position.x:
					$Position2D.rotation_degrees = -45
				elif player.position.y>position.y and player.position.x<position.x:
					$Position2D.rotation_degrees = 135
				elif player.position.y>position.y and player.position.x>position.x:
					$Position2D.rotation_degrees = 45
				else:
					$Position2D.rotation_degrees = rand_range(0,360)
			if direction == 1:
				$AnimationPlayer.play("Attack right")
			elif direction == 0:
				$AnimationPlayer.play("Attack left")
			velocity = Vector2(0,0)
		
	if health <= 0:
		$AnimationPlayer.play("dead")
	move_and_slide(velocity)
	
	
	
	
func _on_Player_detection_zone_body_entered(body):
	player = body
	state = 3

func _on_Player_detection_zone_body_exited(body):
	player = null
	state = 2
	
func on_attack_animation_finished():
	state = 3


func _on_hurtbox_area_entered(area):
	health -=area.damage
	
	
func update_wander():
	state = int(rand_range(1,3))
	print(state)
	$Timer.start(rand_range(1,3))

func dead():
	queue_free()





func _on_Timer_timeout():
	update_target_position()
	
func update_target_position():
	target_vector = Vector2(position.x+rand_range(-20,20), position.y+rand_range(-20,20))
