extends Node2D

var inventory = preload("res://inventory.tres") 

onready var slot = $slot
onready var item = $slot/Item

func _process(delta):
	if inventory.items[0] != null:
		item.texture = inventory.items[0].texture
	else:
		item.texture = null
