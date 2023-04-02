#is initially revolver

extends Node2D

var level = 0
var cooldown_time = 1.0
var ready_to_fire = true
var ammo = 1

var projectile = preload("res://attacks/projectiles/Bullet.tscn") 

var dir = Vector2.RIGHT

onready var main = get_tree().get_nodes_in_group("player")[0].get_parent()
onready var sprite = $Sprite

func _input(event):
	if event is InputEventMouseButton and !event.pressed and event.button_index == BUTTON_LEFT:
		#ready_to_fire = true
		pass

func _process(_delta):
	dir = get_angle_to(get_global_mouse_position())
	if dir > PI/2 or dir < -PI/2:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	sprite.rotation = dir
	if Input.is_mouse_button_pressed( 1 ):
		if level != 0:
			if ready_to_fire:
				var p = projectile.instance()
				p.set_level(level)
				p.set_dir(dir)
				main.call_deferred("add_child", p)
				p.global_position = global_position
				ready_to_fire = false
				$Shot.play()
				$Cooldown.start(cooldown_time)
	

func level_up():
	level += 1
	match level:
		1:
			sprite.set_deferred("visible",true)
			cooldown_time = 0.8
		2: #faster pistol
			cooldown_time = 0.6
		3:# shotgun
			cooldown_time = 0.6
		4: #ak 47
			cooldown_time = 0.2
		5: #assault shotgun
			cooldown_time = 0.2
		6: #gatling gun
			cooldown_time = 0.05
		
func get_name():
	return "Magic Gun"
	
func get_icon():
	return "res://assets/weaponArt/revolver.png"

func get_level():
	return level

func get_desc():
	return "Shoots towards where you click."



func _on_Cooldown_timeout():
	ready_to_fire = true

func _on_Reload_finished():
	ready_to_fire = true
