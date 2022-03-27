extends StaticBody2D
var itemsIn = []



func _on_Area2D_area_entered(area):
	itemsIn.append(area.id)
	itemsIn.sort()
	
	
func _process(delta):
	if itemsIn == [1,7]:
		print("hi")
