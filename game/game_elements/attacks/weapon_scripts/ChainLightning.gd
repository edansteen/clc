extends Node2D

var level = 0
var cooldown_time = 2.0

var projectile = preload("res://game/game_elements/attacks/projectiles/MagicProjectile.tscn") 

onready var main = get_tree().get_nodes_in_group("player")[0].get_parent()

func _ready():
	$CooldownTimer.start(cooldown_time)

func level_up():
	level += 1
	match level:
		1:
			cooldown_time = 2.0
		2:
			cooldown_time = 1.5
		3:
			cooldown_time = 1.25
		4:
			cooldown_time = 1
		5:
			cooldown_time = 0.75
		6:
			#explode on hit
			cooldown_time = 0.5


func get_name():
	return "Chain Lightning"
	
func get_icon():
	return "res://assets/sprites/fish.png"

func get_level():
	return level

func get_desc():
	match level:
		0:
			return "Shoots chaining lightning at nearest enemy"
		1:
			return "Cooldown reduced by 50%. Chain + 1"
		2:
			return "Cooldown reduced by 25%. Chain + 1"
		3:
			return "Cooldown reduced by 33%"
		4:
			return "Cooldown reduced by 50%"
		5:
			return "Projectiles explode on collision"

func _on_CooldownTimer_timeout():
	if level != 0:
		var p = projectile.instance()
		p.set_level(level)
		main.call_deferred("add_child", p)
		p.global_position = global_position
	$CooldownTimer.start(cooldown_time)
