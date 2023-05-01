extends Node2D

var cooldown : float = 6.0
var angle = 0.0

enum type {RIFLE, BLASTER}
var currentType = type.BLASTER

var bolt = preload("res://game/game_elements/mobs/mob_projectiles/BlasterBolt.tscn")

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var main = player.get_parent()
onready var sprite = $Sprite

# randomize gun type
func _ready():
	$ShootTimer.start(cooldown)

func _process(delta):
	var dir = get_angle_to(player.global_position)
	if dir > PI/2 or dir < -PI/2:
		sprite.flip_v = true
	else:
		sprite.flip_v = false
	sprite.rotation = dir

func _on_ShootTimer_timeout():
	var b = bolt.instance()
	main.call_deferred("add_child", b)
	b.global_position = $Muzzle.global_position
	b.set_dir($Muzzle.get_angle_to(player.global_position))
	$ShootTimer.start(cooldown)
