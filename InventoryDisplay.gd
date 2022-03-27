extends GridContainer

var inventory = preload("res://inventory.tres")
signal dropItem(ItemData)
var ItemData

func _ready():
	inventory.connect("items_changed", self,"_on_items_changed")
	inventory.make_items_unique()
	update_inventory_display()
	
func update_inventory_display():
	for item_index in inventory.items.size():
		update_inventory_slot_display(item_index)
	
func update_inventory_slot_display(item_index):
	var inventorySlotDisplay = get_child(item_index)
	var item = inventory.items[item_index]
	inventorySlotDisplay.display_item(item)
	
	
func _on_items_changed(indexes):
	for item_index in indexes:
		update_inventory_slot_display(item_index)

func _unhandled_input(event):
	if event.is_action_released("left_click"):
		if inventory.drag_data is Dictionary:
			for i in inventory.items:
				if i != null:
					if i.name == inventory.drag_data.item.name:
						i.amount += inventory.drag_data.item.amount
						inventory.drag_data = null
						ItemData = null
						break
			if inventory.drag_data != null:
				for i in range(len(inventory.items)):
					if inventory.items[i] == null:
						inventory.set_item(i,inventory.drag_data.item)
						inventory.drag_data = null
						ItemData = null
						break
			
func _process(delta):
	if inventory.drag_data != null:
		ItemData = inventory.drag_data.item
		if inventory.drag_data.item.amount <=0:
			inventory.drag_data = null
			set_drag_preview(null)
	else:
		ItemData = null
	for k in range(len(inventory.items)):
		if inventory.items[k] != null:
			if inventory.items[k].amount <= 0:
				inventory.items[k] = null
		update_inventory_slot_display(k)
			
	
func _input(event):
	if event.is_action_pressed("right_click"):
		if inventory.mouseOverSlot == false:
			if ItemData != null:
				emit_signal("dropItem", ItemData)
			
