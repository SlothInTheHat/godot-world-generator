extends Sprite


func _process(delta):
	for i in range(rand_range(15,25)):
		rotation_degrees+=1
	for i in range(rand_range(15,25)):
		rotation_degrees-=1
