extends Node2D

var level = 0
var cooldown_time = 2.0

var projectile = preload("res://attacks/projectiles/MagicProjectile.tscn") 

onready var main = get_tree().get_nodes_in_group("main")[0]

func _ready():
	$CooldownTimer.start(cooldown_time)

func level_up():
	level += 1
	match level:
		1:
			cooldown_time = 2.0

func get_name():
	return "Magic Missile"
	
func get_icon():
	return "res://assets/sprites/fish.png"

func get_level():
	return level

func get_desc():
	return "Shoots magic projectiles that target the nearest enemy"


func _on_CooldownTimer_timeout():
	if level != 0:
		var p = projectile.instance()
		p.set_level(level)
		main.call_deferred("add_child", p)
		p.global_position = global_position
		$CooldownTimer.start(cooldown_time)
