extends TextureRect
var item = ""
var recipie = null
onready var itemTexture = $ItemTexture
var inventory = preload("res://inventory.tres")
var mouseOver = null
var InvDict = {}
var cancraft = 0
signal craft(item)

func _ready():
	print(recipie)
	var itemfile = load("res://Items/"+item+".tres")
	itemTexture.texture = itemfile.texture

func _process(delta):
	if mouseOver == true:
		if Input.is_action_just_pressed("attack"):
			cancraft = 0
			for i in inventory.items:
				if (i != null) and (InvDict != null):
					if not i.name in InvDict:
						InvDict[i.name] = i.amount
					else:
						InvDict[i.name] += i.amount
			for ingredient in recipie:
				if ingredient in InvDict:
					if InvDict[ingredient] - recipie.get(ingredient) >= 0:
						cancraft += 1
				else:
					cancraft = 0
					break
			if cancraft != 0:
				if cancraft == len(recipie):
					for ingredient in recipie:
						var amount = recipie.get(ingredient)
						for i in inventory.items:
							if (i != null) and (i.name == ingredient):
								var reduction = min(i.amount, amount)
								i.amount-= reduction
								if i.amount == 0:
									i = null
								amount-= reduction
					emit_signal("craft", item)
								
			InvDict = {}
#		if Input.is_action_just_pressed("attack"):
#			for ingredient in recipie:
#				if canCraft != false:
#					amount = 0
#					for i in inventory.items:
#						if canCraft != false:
#							if i != null:
#								if i.name == ingredient:
#									canCraft = true
#									amount += i.amount
#								else:
#									canCraft = false
#						else:
#							break
#					print(amount)
#				else:
#					break
func _on_ItemSlot1_mouse_entered():
	mouseOver = true
	


func _on_ItemSlot1_mouse_exited():
	mouseOver = false

