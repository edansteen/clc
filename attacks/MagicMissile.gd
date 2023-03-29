extends Node2D

var level = 0
var cooldown_time = 2.0

var projectile = preload("res://attacks/projectiles/MagicProjectile.tscn") 

onready var main = get_tree().get_nodes_in_group("main")[0]

func level_up():
	$CooldownTimer.stop()
	match level:
		1:
			cooldown_time = 2.0
	$CooldownTimer.start(cooldown_time)


func _on_CooldownTimer_timeout():
	var p = projectile.instance()
	p.set_level(level)
	main.call_deferred("add_child", p)
	p.global_position = global_position
	$CooldownTimer.start(cooldown_time)
