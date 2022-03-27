extends Node2D

onready var tree = preload("res://vegetation/movingTree.tscn")
onready var bush = preload("res://vegetation/Bush.tscn")
onready var munchstump = preload("res://Munch Stump.tscn")
onready var stone = preload("res://stone.tscn")
onready var player = $YSort/WorldGenerator/YSort/Player
var baseItem = preload("res://Items/baseItem.tscn")

onready var inventoryDisplay = get_node("UI/UI container/InventoryContainer/CenterContainer/VBoxContainer/MarginContainer/InventoryDisplay")
onready var craftingMenu = get_node("UI/UI container/CraftingMenu")

func _ready():
	inventoryDisplay.connect("dropItem", self, "_on_dropItem")
	craftingMenu.connect("createItem", self, "_on_createItem")
	randomize()
		
func _on_dropItem(drag_data):
	var ItemInstance = baseItem.instance()
	ItemInstance.get_child(1).texture = drag_data.texture
	ItemInstance.Name = drag_data.name
	var xpos = get_global_mouse_position().x
	var ypos = get_global_mouse_position().y
	ItemInstance.position = Vector2(xpos,ypos)
	ItemInstance.setItem = load(drag_data.path)
	if drag_data.amount>0:
		$YSort.add_child(ItemInstance)
		drag_data.amount-=1
		
func _on_createItem(item):
	var ItemInstance = baseItem.instance()
	ItemInstance.get_child(1).texture = load("res://Items/"+item+".png")
	ItemInstance.Name = item
	var xpos = player.position.x
	var ypos = player.position.y
	ItemInstance.position = Vector2(xpos,ypos)
	ItemInstance.setItem = load("res://Items/"+item+".tres")
	ItemInstance.position = Vector2(xpos,ypos)
	$YSort.add_child(ItemInstance)
	
	


