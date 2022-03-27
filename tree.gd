extends KinematicBody2D

var branch = preload("res://Items/branch.tres")
var baseItem = preload("res://Items/baseItem.tscn")
var Log = preload("res://Items/log.tres")
var In = null
var health = 10
var world = load("res://World.tscn")
onready var animationplayer = $AnimationPlayer
var instanced = false
func _ready():
	randomize()
	
	
	
	$Sprite.scale.x = rand_range(1.5, 2)
	$Sprite.scale.y = rand_range(1.5, 2.5)
	
	if instanced == true:
		$Sprite.scale = Vector2(0.1,0.1)
	animationplayer.stop()
func _physics_process(delta):
	pass
				
				

func _on_mouse_area_area_entered(area):
	if area.type != "axe":
		$Particles2D.emitting = true
		animationplayer.stop()
		animationplayer.play("hit")
		var chance = int(rand_range(1,5))
		if chance == 3:
			var baseItemInstance = baseItem.instance()
			var baseSprite = baseItemInstance.get_child(1)
			baseSprite.texture = branch.texture
			baseItemInstance.Name = branch.name
			baseItemInstance.setItem = load("res://Items/branch.tres")
			add_child(baseItemInstance)
	else:
		animationplayer.play("hit")
		health -= area.damage
		if health <=0:
			$AnimationPlayer.stop()
			$AnimationPlayer.play("chopped")
	




	
func hitAnimationFinished():
	animationplayer.play("wind")


func _on_Camera_area_entered(area):
	if health > 0:
		animationplayer.playback_speed = rand_range(0.3, 0.6)
		animationplayer.play("wind")
	

func _on_Camera_area_exited(area):
	animationplayer.playback_speed = rand_range(0.3, 0.6)
	animationplayer.stop()


func _on_Timer_timeout():
	if $Sprite.scale.y <= 2.5:
		$Sprite.scale+=Vector2(0.05,0.05)
	elif $Sprite.scale.y>= 2.5:
		$Sprite.scale.y = 2.5
		
#	if $Sprite.scale.y >= 2:
#		var chance = rand_range(1,5)
#		if int(chance) == 3:
#			var newtree = load("res://vegetation/movingTree.tscn")
#			var newtreeinstance = newtree.instance()
#			var smalltree = $YSort.add_child(newtreeinstance)
#			if smalltree != null:
#				smalltree.position = Vector2(rand_range(-20,20),rand_range(-20,20))
#				print(smalltree.position)
#				smalltree.instanced = true
#				print("hi")
#				smalltree = null
		
func chopped():
	$AnimationPlayer.play("fade")
	for i in rand_range(1,3):
		var baseItemInstance = baseItem.instance()
		var baseSprite = baseItemInstance.get_child(1)
		baseSprite.texture = branch.texture
		baseItemInstance.Name = branch.name
		baseItemInstance.setItem = load("res://Items/branch.tres")
		add_child(baseItemInstance)
		position.x += rand_range(-2, 2)
	for i in rand_range(1,3):
		var baseItemInstance = baseItem.instance()
		var baseSprite = baseItemInstance.get_child(1)
		baseSprite.texture = Log.texture
		baseItemInstance.Name = Log.name
		baseItemInstance.setItem = load("res://Items/log.tres")
		add_child(baseItemInstance)
		position.x += rand_range(-2, 2)
func end():
	queue_free()


func _on_Area2D_body_entered(body):
	queue_free()
