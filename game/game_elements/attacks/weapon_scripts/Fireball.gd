extends Node2D

var level = 0
var cooldown_time = 2.0
var projectileNum = 0

var projectile = preload("res://game/game_elements/attacks/projectiles/FireballProjectile.tscn") 

onready var main = get_tree().get_nodes_in_group("player")[0].get_parent()

func _ready():
	$CooldownTimer.start(cooldown_time)

func level_up():
	level += 1
	match level:
		1:
			projectileNum = 1
			cooldown_time = 5
		2:
			cooldown_time = 4
		3:
			projectileNum = 2
			cooldown_time = 3.5
		4:
			cooldown_time = 2.5
		5:
			projectileNum = 3
			cooldown_time = 2
		6:
			projectileNum = 5


func get_name():
	return "Fireball"
	
func get_icon():
	return "res://assets/weaponArt/weapon_icons/magic_projectile_icon.png"

func get_level():
	return level

func get_desc():
	match level:
		0:
			return "Shoots a fireball at a random enemy every 5 seconds"
		1:
			return "Cooldown -1 seconds."
		2:
			return "Cooldown -0.5 seconds. +1 Fireball"
		3:
			return "Cooldown -1 seconds."
		4:
			return "Cooldown -0.5 seconds. +1 Fireball"
		5:
			return "+2 Fireballs."

func _on_CooldownTimer_timeout():
	if level != 0:
		var p = projectile.instance()
		p.set_level(level)
		main.call_deferred("add_child", p)
		p.global_position = global_position
		$Fire.play()
	$CooldownTimer.start(cooldown_time)
