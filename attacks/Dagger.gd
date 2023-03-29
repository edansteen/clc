extends Node2D

var level = 1
var cooldown_time = 1.0

var projectile = preload("res://attacks/projectiles/DaggerProjectile.tscn") 

var dir = Vector2.RIGHT

onready var main = get_tree().get_nodes_in_group("main")[0]

func _ready():
	$Cooldown.start(cooldown_time)


func level_up():
	$Cooldown.stop()
	level += 1
	match level:
		0:
			return
		1:
			cooldown_time = 1.0
	$Cooldown.start(cooldown_time)

func _on_Cooldown_timeout():
	var p = projectile.instance()
	p.set_level(level)
	p.set_dir((get_viewport().get_mouse_position() - global_position).normalized())
	main.call_deferred("add_child", p)
	p.global_position = global_position
	$Cooldown.start(cooldown_time)

