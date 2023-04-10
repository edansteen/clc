extends Node2D

var level = 0
var orb_count = 0 #number of orbs
var damage = 8.0
var rotation_speed = 0.03
var orb_size = 1.0
var radius = 100
var duration = 6.0
var cooldown = 5.0

var projectile = preload("res://attacks/projectiles/BlackHoleProjectile.tscn")
#array with all active orbs
var projectiles = []

onready var main = get_tree().get_nodes_in_group("player")[0].get_parent()

# Called when the node enters the scene tree for the first time.
func level_up():
	level += 1
	
	clear_projectiles()
	match level:
		1:
			orb_count = 2
			damage = 8.0
			orb_size = 1.0
		2:
			damage = 12
			orb_count = 3
		3:
			orb_count = 4
		4:
			orb_count = 5
		5:
			orb_count = 6
		6:
			orb_count = 7
	
	reset_projectiles()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var p = $OriginPoint.position
	radius += 2
	
	for i in range(orb_count):
		#add to array, position, and place in scene
		var angle = (2*PI)/orb_count * (i)
		var proj = projectiles[i]
		proj.position = p + Vector2(cos(angle), sin(angle)) * radius
		proj.position = p + (proj.position - p).rotated(rotation_speed)

func clear_projectiles():
	for i in range(projectiles.size()):
		projectiles[i].queue_free()
	projectiles = []
	
	
func reset_projectiles():
	radius = 10
	for i in range(orb_count):
			#add to array, position, and place in scene
			var angle = (2*PI)/orb_count * (i)
			projectiles.append(projectile.instance())
			projectiles[i].position = $OriginPoint.position + Vector2(cos(angle), sin(angle)) * radius
			projectiles[i].set_level(level)
			call_deferred("add_child", projectiles[i])
	$Duration.start(duration)


func get_name():
	return "Black Hole"
	
func get_icon():
	return "res://assets/weaponArt/orb_sprite.png"

func get_level():
	return level

func get_desc():
	return "Shoots out a black hole that sucks enemies toward it."


func _on_Duration_timeout():
	clear_projectiles()
	$CooldownTimer.start(cooldown)


func _on_CooldownTimer_timeout():
	reset_projectiles()
