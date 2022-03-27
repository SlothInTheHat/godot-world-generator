extends GridContainer

var worldBlock = preload("res://WorldBlock.tscn")
var textures = ["res://background.png", "res://water.png"]
var objects = ["res://vegetation/movingTree.tscn","res://stone.tscn","res://vegetation/Bush.tscn"]
export var lushness = 5
var tree = preload("res://vegetation/movingTree.tscn")
var stone = preload("res://stone.tscn")
var bush = preload("res://vegetation/Bush.tscn")

func _ready():
	randomize()
	lushness = rand_range(1,11)
	for x in columns*columns:
			var worldBlockInstance = worldBlock.instance()
			worldBlockInstance.get_child(0).texture = load(textures[rand_range(0,len(textures))])
			
			if rand_range(1,11) <= lushness:
				if int(rand_range(1,11))%2 == 0:
					worldBlockInstance.get_child(1).add_child(tree.instance())
			add_child(worldBlockInstance)
			
