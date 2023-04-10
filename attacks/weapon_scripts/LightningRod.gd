extends Node2D

var damage = 20.0
var area = 1.0
var projectile_num = 1
var cooldown_time = 4.0 #in s
var level = 0

var rng = RandomNumberGenerator.new()
#find mobs on the screen
var mobs_in_range = []

var lightning = preload("res://attacks/projectiles/LaserStrikeProjectile.tscn")

onready var main = get_tree().get_nodes_in_group("player")[0].get_parent()
	
func level_up():
	level += 1
	match level:
		1:
			damage = 20.0
			area = 1.0
			projectile_num = 1
		2:
			projectile_num = 2
			area *= 1.1
		3:
			projectile_num = 3
			area *= 1.1
		4:
			projectile_num = 4
			area *= 1.1
		5:
			projectile_num = 5
			area *= 1.1
		6:
			projectile_num = 6
			area *= 1.1
	$Range/CollisionShape2D.scale *= area

func set_damage(d):
	damage = d

func get_name():
	return "Laser Strike"
	
func get_icon():
	return "res://assets/weaponArt/orb_sprite.png"

func get_level():
	return level

func get_desc():
	return "Periodically strikes a random enemy with lightning, dealing high damage"


func _on_CooldownTimer_timeout():
	if level != 0 and mobs_in_range.size() > 0:
		for _i in range(projectile_num):
			var l = lightning.instance()
			l.set_level(level)
			#strike random enemy in range
			l.global_position = mobs_in_range[rng.randi_range(0,mobs_in_range.size()-1)].global_position
			main.call_deferred("add_child", l)
			$ThunderClap.play()
	$CooldownTimer.start(cooldown_time)


func _on_Range_body_entered(body):
	if !mobs_in_range.has(body):
		if body.has_method("hit_for"):
			mobs_in_range.append(body)


func _on_Range_body_exited(body):
	if mobs_in_range.has(body):
		mobs_in_range.erase(body)
