extends Node2D

export var speed = 2

export (bool) var moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var moving = true

func move(b):
	moving = b
	
func _process(delta):
	if moving:
		position.x -= speed 
