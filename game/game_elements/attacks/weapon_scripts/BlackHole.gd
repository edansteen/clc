extends Node2D

var level = 0
var cooldown = 5.0
var projectile_count = 0

var projectile = preload("res://game/game_elements/attacks/projectiles/BlackHoleProjectile.tscn")

onready var origin_point = $OriginPoint
onready var main = get_tree().get_nodes_in_group("player")[0].get_parent()

# Called when the node enters the scene tree for the first time.
func level_up():
	level += 1
	
	match level:
		1:
			projectile_count = 1
			$CooldownTimer.start(cooldown)

func get_name():
	return "Black Hole"
	
func get_icon():
	return "res://assets/weaponArt/orb_sprite.png"

func get_level():
	return level

func get_desc():
	match level:
		0:
			return "Shoots out a black hole that sucks enemies toward it."

func _on_CooldownTimer_timeout():
	for i in range(projectile_count):
		var p = projectile.instance()
		p.set_level(level)
		main.call_deferred("add_child", p)
	$CooldownTimer.start(cooldown)
