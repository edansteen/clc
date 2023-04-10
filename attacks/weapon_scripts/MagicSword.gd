extends Node2D

var level = 0
var cooldown_time = 1.0
var ready_to_strike = true

var dir = Vector2.RIGHT

var slash = preload("res://attacks/projectiles/SwordSlash.tscn")

onready var main = get_tree().get_nodes_in_group("player")[0].get_parent()


func _process(_delta):
	dir = get_angle_to(get_global_mouse_position())
	if Input.is_mouse_button_pressed( 1 ) or Input.is_action_pressed("special"):
		if level != 0:
			if ready_to_strike:
					var s = slash.instance()
					s.set_level(level)
					main.call_deferred("add_child", s)
					s.global_position = global_position
					s.rotate(dir)
					ready_to_strike = false
					$Slash.play()
					$Cooldown.start(cooldown_time)
	

func level_up():
	level += 1
	match level:
		1:
			cooldown_time = 0.8
		2:
			cooldown_time = 0.5
		3:
			cooldown_time = 0.6
		4:
			cooldown_time = 0.2
		5:
			cooldown_time = 0.2
		6:
			cooldown_time = 0.05
		
func get_name():
	return "Magic Sword"
	
func get_icon():
	return "res://assets/weaponArt/revolver.png"

func get_level():
	return level

func get_desc():
	return "Short-range slash when you click"


func _on_Cooldown_timeout():
	ready_to_strike  = true
