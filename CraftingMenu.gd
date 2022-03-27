extends TextureRect
var materials_dict = {}
var inventorypath = preload("res://inventory.tres")
var inventory = inventorypath
var craftindSlot = preload("res://CraftingSlot.tscn")
var recipies
var result = []
var items = {}
var inventoryItems = []
var canCraft
var discovered_recipies = {}
onready var grid = $MarginContainer/GridContainer
signal createItem(item)




func _ready():
	var recipies_file = File.new()
	recipies_file.open("res://data/recipies.json", File.READ)
	var recipiesData_json = JSON.parse(recipies_file.get_as_text())
	recipies_file.close()
	recipies = recipiesData_json.result
	print(recipies)
func _process(delta):
	
	for i in inventory.items:
		if i != null:
			if not i.name in inventory:
				inventoryItems.append(i.name)
	
	for item in recipies.keys():
		canCraft = null
		materials_dict = recipies.get(item)
		
		for material in materials_dict.keys():
			if canCraft != false:
				if material in inventoryItems:
					canCraft = true
				else:
					canCraft = false
			elif canCraft == false:
				break
		if canCraft == true:
			
			if not item in discovered_recipies:
				discovered_recipies[item] = recipies.get(item)
				var slotinstance = craftindSlot.instance()
				slotinstance.item = item
				slotinstance.recipie = recipies.get(item)
				grid.add_child(slotinstance)
				var craftingSlot = slotinstance
				craftingSlot.connect("craft", self, "_on_craft")
		canCraft = null
	inventoryItems = []
	
	
func _on_craft(item):
	emit_signal("createItem", item)
