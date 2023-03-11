extends Node2D

var moving = false
var speed = 2
var time = 0
var distance = 0
var env_length = 1024 #length in px

var powerup = preload("res://runner/environment/env_elements/powerups/Powerup.tscn")
var trashcan = preload("res://runner/environment/env_elements/obstacles/TrashCan.tscn")
var yarnball = preload("res://runner/environment/env_elements/obstacles/YarnBall.tscn")
var laserpointer = preload("res://runner/environment/env_elements/obstacles/LaserPointer.tscn")

var obstacles = [trashcan, yarnball, laserpointer]

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	moving = false
func move(b):
	moving = b

func set_speed(s):
	speed = s
	
func get_distance():
	return distance

func _process(delta):
	if moving:
		position.x -= speed 
		time += delta
		distance = round(speed*time)
	if position.x <= -(env_length):
		position.x += env_length*2
		reset_obstacles()

func reset_obstacles():
	#clear current obstacles in environment node
	for node in $Obstacles.get_children():
		$Obstacles.remove_child(node)
	#add obstacles at random
	if get_distance() > 10:
		#randomize tilemap
		$GroundPreloads.clear()
		for i in range(16):
			for j in range(7,9):
				#$TileMap.set_cell(i,j)
				pass
		#create new instance of random obstacle in the array
		#$Obstacles.call_deferred("add_child", obstacles[rng.randi_range(0,len(obstacles)-1)].instance())
		
		if rng.randi_range(0,50) == 50: #have a small chance of spawning a powerup
			$Obstacles.call_deferred("add_child", powerup.instance())
