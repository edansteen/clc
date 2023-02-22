extends Node2D

export var speed = 2

export (bool) var moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	moving = false

func move(b):
	moving = b
	
func _process(_delta):
	if moving:
		position.x -= speed 
	if position.x <= -1024:
		position.x += 2048
