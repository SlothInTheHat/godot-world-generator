extends TileMap
var x = 0
var y = 0
var water = 0


func _ready():
	makesquare(x,y)
	
	

	
	
func makesquare(x,y):
	for i in range(-80,80):
		for j in range(-80,80):
			var randwater = rand_range(0,500)
			if randwater > 1:
				set_cellv(Vector2(i+x,j+y),8)
			else:
				set_cellv(Vector2(i+x,j+y),6)
	for h in range(5):
		for i in range(-80, 80):
			for j in range(-80, 80):
				if get_cell(i,j) == 8 and get_cell(i-1,j) == 6:
					var randcell = rand_range(1,3)
					if randcell < 2:
						set_cellv(Vector2(i,j),6)
						
				if get_cell(i,j) == 8 and get_cell(i,j-1) == 6:
					var randcell = rand_range(1,3)
					if randcell < 2:
						set_cellv(Vector2(i,j),6)
				
				if get_cell(i,j) == 8 and get_cell(i+1,j) == 6:
					var randcell = rand_range(1,3)
					if randcell < 2:
						set_cellv(Vector2(i,j),6)
				
				if get_cell(i,j) == 8 and get_cell(i,j+1) == 6:
					var randcell = rand_range(1,3)
					if randcell < 2:
						set_cellv(Vector2(i,j),6)
				
				
	for k in range(3):
		for l in range(-80, 80):
			for m in range(-80, 80):
				if get_cell(l,m) == 8 and get_cell(l,m+1) == 6 and get_cell(l+1,m) == 6 and get_cell(l-1,m) == 6 and get_cell(l,m-1) == 6:
					set_cellv(Vector2(l,m),6)
	
	
	for l in range(-80, 80):
		for m in range(-80, 80):
			if get_cell(l,m) == 8 and get_cell(l,m-1) == 6:
				set_cellv(Vector2(l,m),10)
				
