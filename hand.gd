extends Sprite
onready var inventory = preload("res://inventory.tres")
var current_item = null
var follow = true
func _ready():
	if inventory.items[0] == null:
		set_item("res://objects/sword.tscn")
		current_item = null
	else:
		set_item(inventory.items[0])
		current_item = inventory.items[0].name
		
		
func _process(delta):
	if Input.is_action_just_pressed("roll"):
		follow = false
	if follow == true:
		look_at(get_global_mouse_position())
	else:
		rotation_degrees = 0
	if inventory.items[0] != null:
		if current_item != inventory.items[0].name:
			get_child(0).queue_free()
			set_item(inventory.items[0])
	elif current_item != null and inventory.items[0] == null:
		get_child(0).queue_free()
		set_item("res://objects/sword.tscn")

		
func set_item(item):
	if item is Resource:
		var object
		
		if item.object != "res://objects/":
			object = load(item.object).instance()
		else:
			object = load("res://objects/sword.tscn").instance()
			
		if item.held != null:
			object.get_child(0).texture = item.held
		else:
			object.get_child(0).texture = item.texture
			
		object.get_child(1).damage = item.damage
		current_item = item.name
		add_child(object)
	else:
		var object = load(item).instance()
		object.get_child(1).damage = 1
		current_item = null
		add_child(object)
	print("set_item")

func roll_end():
	follow = true
