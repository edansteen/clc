extends Node2D

export var speed = 2
export (bool) var moving = false

var powerup = preload("res://environment/powerups/Powerup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 2
	moving = false
	var o = powerup.instance()
	call_deferred("add_child", o)

func move(b):
	moving = b

func set_speed(s):
	speed = s
	
func _process(_delta):
	if moving:
		position.x -= speed 
	if position.x <= -1024:
		position.x += 2048
		reset_obstacles()

func reset_obstacles():
	#clear current obstacles in environment node
	for node in $Obstacles.get_children():
		$Obstacles.remove_child(node)
		
	#add obstacles/powerups/fish_coins at random
	var rng = RandomNumberGenerator.new()
	var random_number = rng.randi_range(0,3)
#	var o = obstacle.instance()
#	call_deferred("add_child", o)
	
