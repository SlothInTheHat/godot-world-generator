extends StaticBody2D
var stone = preload("res://Items/stone.tres")




func _on_Area2D_area_entered(area):
	$AnimationPlayer.play("broken")
	var baseitem = preload("res://Items/baseItem.tscn")
	var stonedrop = baseitem.instance()
	stonedrop.Name = stone.name
	stonedrop.get_child(1).texture = stone.texture
	stonedrop.setItem = load("res://Items/stone.tres")
	add_child(stonedrop)
	


func broken():
	queue_free()


func _on_Area2D2_body_entered(body):
	queue_free()
