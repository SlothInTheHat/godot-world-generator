extends Node2D
onready var inventory = preload("res://inventory.tres")
onready var sprite = $Sprite
onready var attack = $Area2D
onready var animate = $AnimationPlayer
var type = null

func _process(delta):
	set_held()
	if Input.is_action_just_pressed("left_click"):
		attack()
		
		
func attack():
	animate.play("attack")
func attack_done():
	animate.play("idle")
func set_held():
	if inventory.items[0] != null:
		if inventory.items[0].type != type:
			type = inventory.items[0].type
			attack.type = type
			sprite.texture = inventory.items[0].held
	else:
		type = "none"
		sprite.texture = null
