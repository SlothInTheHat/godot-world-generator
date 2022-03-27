extends Area2D
var player = null
var inventory = load("res://inventory.tres")
var inventorySlotDisplay = load("res://InventorySlotDisplay.gd")
var inventoryDisplay = load("res://InventoryDisplay.gd")
var velocity = Vector2()
var Name = ""
var setItem = null
var itemslist = []
var done = false

func _on_BaseItemDrop_body_entered(body):
	player = body
	

	
func _process(_delta):
	if player != null:
		var angle = get_angle_to(player.position)
		velocity = Vector2(cos(angle), sin(angle))*0.5
		
		
		for j in range(len(inventory.items)):
						if inventory.items[j] != null:
							itemslist.append(inventory.items[j].amount)
						else:
							itemslist.append(null)
		
		for i in range(len(inventory.items)):
			if inventory.items[i] != null:
				if inventory.items[i].name == Name:
					itemslist[i] += 1
					done = true
					break
			
		if done != true:
			for i in range(len(inventory.items)):
				if inventory.items[i] == null:
					inventory.set_item(i,setItem)
					inventory.make_items_unique()
					done = true
					break
		
		for i in range(len(inventory.items)):
			if inventory.items[i] != null and itemslist[i] != null:
				inventory.items[i].amount = itemslist[i]
		
		if done == true:
			queue_free()

	else:
		velocity = Vector2(0,0)
	position += velocity


func _on_BaseItemDrop_body_exited(_body):
	player = null
	

