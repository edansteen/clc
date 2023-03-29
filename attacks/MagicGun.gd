extends Node2D

var level = 0
var cooldown_time = 1.0
var ready_to_fire = true

var projectile = preload("res://attacks/projectiles/Bullet.tscn") 

var dir = Vector2.RIGHT

onready var main = get_tree().get_nodes_in_group("main")[0]

func _process(delta):
	if Input.is_mouse_button_pressed( 1 ):
		if level != 0:
			if ready_to_fire:
				var p = projectile.instance()
				p.set_level(level)
				p.set_dir(get_angle_to(get_global_mouse_position()))
				main.call_deferred("add_child", p)
				p.global_position = global_position
				ready_to_fire = false
				$Cooldown.start(cooldown_time)

func level_up():
	level += 1
	match level:
		1:
			cooldown_time = 1.0

func get_name():
	return "Magic Gun"
	
func get_icon():
	return "res://assets/weaponArt/revolver.png"

func get_level():
	return level

func get_desc():
	return "Shoots a magic bullet towards where you click."



func _on_Cooldown_timeout():
	ready_to_fire = true
