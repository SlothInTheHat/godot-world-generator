extends TextureRect
var item = null
var inventory = preload("res://inventory.tres")
var mouseIn = false
var itemName = null
var inInventory = false
var craftingMenu = load("res://CraftingMenu.tscn")
signal ingrediantsUsed


func _process(delta):
	if Input.is_action_just_pressed("left_click") and item != null and mouseIn == true:
		for i in range(len(inventory.items)):
			if inventory.items[i] != null:
				if itemName == inventory.items[i].name:
					inventory.items[i].amount += 1
					inInventory = true
					emit_signal("ingrediantsUsed")
					item = null
					itemName = null
					break
		if inInventory == false:
			for i in range(len(inventory.items)):
				if inventory.items[i] == null:
					inventory.set_item(i, item)
					emit_signal("ingrediantsUsed")
					item = null
					itemName = null
					break
				

func _on_ResultImage_mouse_entered():
	mouseIn = true


func _on_ResultImage_mouse_exited():
	mouseIn = false
