extends Popup

var origin = ""
var slot = ""
var valid = false

func _ready():
	var item_id
	if origin == "Inventory":
		if PlayerData.inv_data[slot]["Item"] != null:
			item_id = str(PlayerData.inv_data[slot]["Item"])
			valid = true
	else:
		if PlayerData.equipment_data[slot] != null:
			item_id = str(PlayerData.equipment_data[slot])
			valid = true
			
	if valid:
		pass
