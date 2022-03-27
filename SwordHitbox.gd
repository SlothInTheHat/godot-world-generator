extends "res://Hitbox.gd"
var inventory = preload("res://inventory.tres")
var knockback_vector = Vector2.ZERO
var id = null
var type = null

func _process(delta):
	if inventory.items[0] != null: 
		if inventory.items[0].damage != null:
			damage = inventory.items[0].damage
		id = inventory.items[0].id
		type = inventory.items[0].type
	else:
		damage = 1
		id = null
		type = null
	
