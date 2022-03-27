extends Node2D

onready var image = $Sprite

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func _physics_process(delta):
	position = get_global_mouse_position()
