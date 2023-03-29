extends Node2D

var level = 1
var orb_count = 1 #number of orbs
var damage = 8.0
var rotation_speed = 0.03
var orb_size = 1.0
var radius = 100
var angle = 0

var orb = preload("res://attacks/projectiles/OrbProjectile.tscn")

#array with all active orbs
var orbs = []

onready var point = $OriginPoint.global_position

# Called when the node enters the scene tree for the first time.
func level_up():
	level += 1
	for node in orbs:
		node.erase()
	match level:
		0: 
			orb_count = 0
		1:
			orb_count = 1
			damage = 8.0
			rotation_speed = 0.03
			orb_size = 1.0
			radius = 100
		2:
			damage = 12
			orb_count = 2
			rotation_speed = 0.05
		3:
			orb_count = 3
		4:
			orb_count = 4
		5:
			orb_count = 5
		6:
			orb_count = 6
	
	for i in range(orb_count):
			#add to array, position, and place in scene
			angle = (2*PI)/orb_count * (i)
			orbs.append(orb.instance())
			orbs[i].position = point + Vector2(cos(angle), sin(angle)) * radius
			orbs[i].set_level(level, 1.0)
			call_deferred("add_child",orbs[i])

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for o in orbs:
		o.position = point + (o.position - point).rotated(rotation_speed)
