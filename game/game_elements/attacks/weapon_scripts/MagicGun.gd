#is initially revolver

extends Node2D

var level = 0
var cooldown_time = 1.0
var ready_to_fire = true
var spread = 0.0 #bullet spread (+/- the given angle IN RADIANS)
var bullet_number = 1

var projectile = preload("res://game/game_elements/attacks/projectiles/Bullet.tscn") 

var dir = Vector2.RIGHT

var rng = RandomNumberGenerator.new()

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
	if Input.is_mouse_button_pressed( 1 ) or Input.is_action_pressed("special"):
		if level != 0:
			if ready_to_fire:
				for _i in range(0, bullet_number):
					var p = projectile.instance()
					p.set_level(level)
					p.set_dir(dir + rng.randf_range(0-spread, spread))
					main.call_deferred("add_child", p)
					p.global_position = global_position
					ready_to_fire = false
					$Shot.play()
					$Cooldown.start(cooldown_time)
	

func level_up():
	level += 1
	match level:
		1:
			spread = 0
			bullet_number = 1
			$Sprite.set_deferred("visible",true)
			cooldown_time = 0.8
		2: #faster pistol
			cooldown_time = 0.5
		3:# shotgun
			bullet_number = 8
			spread = 0.8
			cooldown_time = 0.6
		4: #ak 47
			bullet_number = 1
			spread = 0.1
			cooldown_time = 0.2
		5: #assault shotgun
			bullet_number = 5
			spread = 0.7
			cooldown_time = 0.2
		6: #gatling gun
			SaveScript.game_data.oneUnlocked = true
			SaveScript.save()
			bullet_number = 3
			spread = 0.15
			cooldown_time = 0.05
		
func get_name():
	return "Magic Gun"
	
func get_icon():
	return "res://assets/weaponArt/revolver.png"

func get_level():
	return level

func get_desc():
	match level:
		0:
			return "Shoots a bullet to where you click."
		1:
			return "Evolved pistol. Shorter cooldown."
		2: 
			return "Pistol evolves to shotgun."
		3:
			return "Shotgun evolves to assault rifle."
		4:
			return "Assault rifle evolves into assault shotgun."
		5:
			return "Assault shotgun evolves into gatling gun"


func _on_Cooldown_timeout():
	ready_to_fire = true
