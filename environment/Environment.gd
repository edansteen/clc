extends Node2D

var moving = false
var speed = 2
var time = 0

var powerup = preload("res://environment/env_elements/powerups/Powerup.tscn")
var trashcan = preload("res://environment/env_elements/obstacles/TrashCan.tscn")
var yarnball = preload("res://environment/env_elements/obstacles/YarnBall.tscn")
var laserpointer = preload("res://environment/env_elements/obstacles/LaserPointer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	moving = false
func move(b):
	moving = b

func set_speed(s):
	speed = s
	
func get_distance():
	return round(speed*time)

func _process(delta):
	if moving:
		position.x -= speed 
		time += delta
	if position.x <= -1024:
		position.x += 2048
		reset_obstacles()

func reset_obstacles():
	#clear current obstacles in environment node
	for node in $Obstacles.get_children():
		$Obstacles.remove_child(node)
	
	#add obstacles/powerups/fish_coins at random
	var rng = RandomNumberGenerator.new()
	var _random_number = rng.randi_range(0,3)
#	var o = obstacle.instance()
#	call_deferred("add_child", o)
