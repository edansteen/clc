extends Node2D

var level = 0
var orb_count = 1 #number of orbs
var damage = 8.0
var rotation_speed = 0.03
var orb_size = 1.0
var radius = 100
var angle = 0

var orb = preload("res://game/game_elements/attacks/projectiles/OrbProjectile.tscn")

#array with all active orbs
var orbs = []

# Called when the node enters the scene tree for the first time.
func level_up():
	level += 1
	for i in range(orbs.size()):
		orbs[i].queue_free()
	orbs = []
	match level:
		1:
			orb_count = 2
			damage = 8.0
			rotation_speed = 0.03
			orb_size = 1.0
			radius = 90
		2:
			damage = 12
			orb_count = 3
			rotation_speed = 0.05
			radius = 100
		3:
			orb_count = 4
		4:
			orb_count = 5
		5:
			orb_count = 6
		6:
			orb_count = 7
	
	for i in range(orb_count):
			#add to array, position, and place in scene
			angle = (2*PI)/orb_count * (i)
			orbs.append(orb.instance())
			orbs[i].position = $OriginPoint.position + Vector2(cos(angle), sin(angle)) * radius
			orbs[i].set_level(level, 1.0)
			call_deferred("add_child",orbs[i])

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var p = $OriginPoint.position
	for o in orbs:
		o.position = p + (o.position - p).rotated(rotation_speed)


func get_name():
	return "Cosmic Orbs"
	
func get_icon():
	return "res://assets/weaponArt/weapon_icons/orb_icon.png"

func get_level():
	return level

func get_desc():
	match (level):
		0:
			return "Summons orbs that rotate around the player, damaging \nenemies."
		1:
			return "+1 Orb"
		2:
			return "+1 Orb"
		3:
			return "+1 Orb"
		4:
			return "+1 Orb"
		5:
			return "+1 Orb"
