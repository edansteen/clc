extends Node2D

export var speed = 2

export (bool) var moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func move(b):
	moving = b
	
func _process(_delta):
	if moving:
		position.x -= speed 

func _on_VisibilityNotifier2D_screen_exited():
	print("EXITED")
	queue_free()
