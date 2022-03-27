extends Node2D

export var width = 3000/5
export var height = 1000/5
export var special_tiles = {}
onready var tilemap = $TileMap
onready var y_sort = $YSort
onready var player = $YSort/Player
var temperature = {}
var moisture = {}
var altitude = {}
var biome = {}
var tiles = {"grass":0, "jungle_grass":1, "sand":2, "snow":3, "water":4, "mountain": 5, "taiga_grass":6, "mushroom_grass":7, "swamp_grass":8, "stone":9, "tree":10, "mud":11, "swamp_water":12}
var biome_data = {"plains":{"grass":95, "tree": 3, "stone":2}, 
				"jungle":{"jungle_grass":95, "tree": 4, "stone":1}, 
				"ocean":{"water":100}, 
				"beach":{"sand":96, "tree": 1, "stone":3}, 
				"taiga":{"taiga_grass":95, "tree": 3, "stone":2}, 
				"desert":{"sand":96, "stone":4}, 
				"snow":{"snow":96, "tree": 2, "stone":3}, 
				"lake":{"water":100},
				"mushroom":{"mushroom_grass":95, "tree": 3, "stone":2}, 
				"swamp":{"swamp_grass":65, "swamp_water": 20, "stone":2, "tree":3, "mud":10}, 
				"mountain":{"mountain":89, "tree": 1, "stone":5, "taiga_grass":5}}


var openSimplexNoise = OpenSimplexNoise.new()

func generate_map(per, oct):
	openSimplexNoise.seed = randi()
	openSimplexNoise.period = per
	openSimplexNoise.octaves = oct
	var gridName = {}
	for x in width:
		for y in height:
			var rand := 2*(abs(openSimplexNoise.get_noise_2d(x,y)))
			gridName[Vector2(x,y)] = rand
	return gridName

func _ready() -> void:
	randomize()
	temperature = generate_map(300, 5)
	moisture = generate_map(300, 5)
	altitude = generate_map(150, 5)
	set_tile(width, height)
	
func _process(delta):
	player_tile()
	
	


func set_tile(width,height):
	for x in width:
		for y in height:
			var pos = Vector2(x,y)
			var alt = altitude[pos]
			var temp = temperature[pos]
			var moist = moisture[pos]
			if alt < 0.2:
				tilemap.set_cellv(pos, 4)
				biome[pos] = "ocean"
				
				
			elif between(alt, 0.2, 0.25):
				if moist > 0:
					tilemap.set_cellv(pos, 2)
					biome[pos] = "beach"
					
					
			elif between(alt, 0.25, 0.8):
				if between(moist, 0, 0.4) and between(temp, 0.2, 0.6):
					tilemap.set_cellv(pos, tiles[random_tile("plains")])
					biome[pos] = "plains"
				elif between(moist, 0.4, 0.9) and temp > 0.6:
					tilemap.set_cellv(pos, tiles[random_tile("jungle")])
					biome[pos] = "jungle"
				elif between(moist, 0.4, 0.9) and between(temp, 0.3, 0.6):
					tilemap.set_cellv(pos, tiles[random_tile("taiga")])
					biome[pos] = "taiga"
				elif temp > 0.7 and moist < 0.4:
					tilemap.set_cellv(pos, tiles[random_tile("desert")])
					biome[pos] = "desert"
				elif temp < 0.1 and moist <0.3:
					tilemap.set_cellv(pos, tiles[random_tile("snow")])
					biome[pos] = "snow"
				elif moist > 0.9:
					tilemap.set_cellv(pos, tiles[random_tile("lake")])
					biome[pos] = "lake"
				elif between(moist, 0, 0.5) and between(temp, 0.1, 0.2) or between(moist, 0.4, 0.5) and between(temp, 0.2, 0.3):
					tilemap.set_cellv(pos, tiles[random_tile("taiga")])
					biome[pos] = "taiga"
				elif between(temp, 0.6, 0.7) and between(moist, 0, 0.4):
					tilemap.set_cellv(pos, tiles[random_tile("mushroom")])
					biome[pos] = "mushroom"
				else:
					tilemap.set_cellv(pos, tiles[random_tile("swamp")])
					biome[pos] = "swamp"
					
					
			elif between(alt, 0.8, 0.95):
				tilemap.set_cellv(pos, tiles[random_tile("mountain")])
				biome[pos] = "mountain"
			else:
				if temp < 0.2:
					tilemap.set_cellv(pos, tiles[random_tile("snow")])
					biome[pos] = "snow"
				else:
					tilemap.set_cellv(pos, tiles[random_tile("mountain")])
					biome[pos] = "mountain"
			if moist >= 0.9:
				tilemap.set_cellv(pos, tiles[random_tile("lake")])
				biome[pos] = "lake"
	tile_to_scene()



func _input(event):
	if Input.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()

func between(val, start, end):
	if start <= val and val < end:
		return true

func hide_old_code():
#	for x in width:
#		for y in height:
#			var pos = Vector2(x,y)
#			var alt = altitude[pos]
#			var temp = temperature[pos]
#			var moist = moisture[pos]
#			if altitude[pos] > 0.1:
#				if alt <= 0.14 and moist > 0.25:
#					tilemap.set_cellv(pos, 2)
#					biome[pos] = "beach"
#				elif alt > 0.1 and alt <= 0.4 and moist > 0.15 and moist <= 0.3 and temp > 0.2 and temp <= 0.35:
#					tilemap.set_cellv(pos, 0)
#					biome[pos] = "plains"
#				elif alt > 0.1 and alt <= 0.4 and moist > 0.3 and moist <= 0.45 and temp > 0.3:
#					tilemap.set_cellv(pos,1)
#					biome[pos] = "jungle"
#				elif alt > 0.25 and alt <= 0.43 and moist > 0.15 and moist <= 0.3 and temp > 0.1 and temp <= 0.2:
#					tilemap.set_cellv(pos,6)
#					biome[pos] = "taiga"
#				elif temp > 0.4 and moist < 0.15 and alt >= 0.14 and alt <= 0.4:
#					tilemap.set_cellv(pos, 2)
#					biome[pos] = "desert"
#				elif alt > 0.4 and alt <= 0.47 and moist <= 0.15:
#					tilemap.set_cellv(pos, 5)
#					biome[pos] = "mountain"
#				elif alt >= 0.47 and temp < 0.2:
#					tilemap.set_cellv(pos, 3)
#					biome[pos] = "snow"
#				else:
#					tilemap.set_cellv(pos, 0)
#					biome[pos] = "plains"
#			else:
#				tilemap.set_cellv(pos, 4)

# Attempt 2
#			if alt > 0.2:
#				if between(alt, 0, 0.28) and moist > 0.5:
#					tilemap.set_cellv(pos, 2)
#					biome[pos] = "beach"
#				elif between(alt, 0.2, 0.8) and between(moist, 0, 0.4) and between(temp, 0.3, 0.7):
#					tilemap.set_cellv(pos, 0)
#					biome[pos] = "plains"
#				elif between(alt, 0.2, 0.8) and between(moist, 0.4, 0.9) and temp > 0.7:
#					tilemap.set_cellv(pos,1)
#					biome[pos] = "jungle"
#				elif between(alt, 0.5, 0.86) and between(moist, 0.4, 0.9) and between(temp, 0.3, 0.6):
#					tilemap.set_cellv(pos,6)
#					biome[pos] = "taiga"
#				elif temp > 0.7 and moist < 0.4 and between(alt, 0.28, 0.8):
#					tilemap.set_cellv(pos, 2)
#					biome[pos] = "desert"
#				elif between(alt, 0.8, 0.94) and moist <= 0.15:
#					tilemap.set_cellv(pos, 5)
#					biome[pos] = "mountain"
#				elif alt >= 0.7 and temp < 0.3 and moist <0.5:
#					tilemap.set_cellv(pos, 3)
#					biome[pos] = "snow"
#				elif moist > 0.9:
#					tilemap.set_cellv(pos, 4)
#					biome[pos] = "lake"
#				else:
##					tilemap.set_cellv(pos, 0)
##					biome[pos] = "plains"
#					pass
#			else:
#				tilemap.set_cellv(pos, 4)
	pass

func random_tile(biome):
	biome = biome_data[biome]
	var temp_list = []
	for i in biome:
		for j in biome[i]:
			temp_list.append(i)
	var chance = rand_range(1,100)
	return temp_list[chance]

func tile_to_scene():
	for i in special_tiles:
		var cells = tilemap.get_used_cells_by_id(i)
		for j in cells:
			tilemap.set_cellv(j, tilemap.get_cellv(j + Vector2(0, -1)))
			var instance = special_tiles[i].instance()
			instance.position = tilemap.map_to_world(j) + Vector2(4, 4)
			y_sort.add_child(instance)
			

func player_tile():
	tilemap.world_to_map(player.position)
	

