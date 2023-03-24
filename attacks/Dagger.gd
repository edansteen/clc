extends Node2D


var level = 1
var cooldown_time = 1.0

var projectile = preload("res://attacks/projectiles/DaggerProjectile.tscn") 

var dir = Vector2.RIGHT
var player_dir = Vector2.ZERO

onready var main = get_tree().get_nodes_in_group("main")[0]

func _ready():
	$Cooldown.start(cooldown_time)

func set_level(lvl):
	level = lvl
	match level:
		1:
			cooldown_time = 1.0

func _process(_delta):
	player_dir = get_tree().get_nodes_in_group("player")[0].get_vel()
	if player_dir != Vector2.ZERO:
		dir = player_dir

func _on_Cooldown_timeout():
	var p = projectile.instance()
	p.set_level(level)
	p.set_dir(dir)
	main.call_deferred("add_child", p)
	p.global_position = global_position
	$Cooldown.start(cooldown_time)

