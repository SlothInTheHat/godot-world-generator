extends Area2D

var player_attack = null

func player_in_range():
	return player_attack != null

func _on_Attack_Zone_body_entered(body):
	player_attack = body

func _on_Attack_Zone_body_exited(body):
	player_attack = null
