extends Node2D

var level = 1
var cooldown_time = 2.0

var projectile = preload("res://attacks/projectiles/MagicProjectile.tscn") 

func _ready():
	$CooldownTimer.start(cooldown_time)

func set_level(lvl):
	level = lvl
	match level:
		1:
			cooldown_time = 2.0


func _on_CooldownTimer_timeout():
	var p = projectile.instance()
	p.set_level(level)
	get_tree().get_nodes_in_group("main")[0].call_deferred("add_child", p)
	p.global_position = global_position
	$CooldownTimer.start()
