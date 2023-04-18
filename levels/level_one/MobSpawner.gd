extends Node2D

export var active: bool = false

#difficulty level
var mob_cap: int = 50 #maximum number of mobs that can be spawned
var spawn_delay: float = 1.0 #in s

onready var player = get_tree().get_nodes_in_group("player")[0]

var rng := RandomNumberGenerator.new()

#preload of all mobs
var mobs = [
	preload("res://mobs/Droid.tscn"),
	preload("res://mobs/Boombot.tscn"),
	preload("res://mobs/ThreeBotsInTrenchCoat.tscn"),
	preload("res://mobs/DogBot.tscn"),
	preload("res://mobs/DestroyerBot.tscn")
]

# Probability of spawning mob measured as a float from 0 to 1. 
#spawn_probability[0] refers to probability of spawning the mob at mobs[0] (which would be the droid)
var spawn_probability = [1.0, 0.0, 0.0, 0.0, 0.0]

#preload all bosses
var bosses = [
	preload("res://mobs/bosses/BullBoss/RoboBull.tscn"),
	preload("res://mobs/bosses/SnakeBoss/SnakeHead.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	active = false
	set_level(1)


func _process(_delta):
	if active and $Mobs.get_child_count() < mob_cap:
		#spawn mobs
		var m = mobs[rand_mob()].instance()
		m.global_position = get_random_position()
		$Mobs.call_deferred("add_child", m)
		active = false
		$CooldownTimer.start(spawn_delay)


func set_active(b):
	active = b

func set_level(n):
	match n:
		1:
			spawn_delay = 0.8
			mob_cap = 50
			spawn_probability = [1.0, 0.0, 0.0, 0.0, 0.0]
		2: 
			spawn_delay = 0.6
			mob_cap = 80
			spawn_probability = [0.75, 0.25, 0.0, 0.0, 0.0]
		3:
			spawn_delay = 0.4
			mob_cap = 120
			spawn_probability = [0.6, 0.1, 0.3, 0.0, 0.0]
		4:
			spawn_delay = 0.2
			mob_cap = 120
			spawn_probability = [0.0, 0.8, 0.9, 0.3, 0.0]
		5:
			spawn_delay = 0.1
			mob_cap = 150
			spawn_probability = [1.0,1.0,1.0, 0.1 ,0.1]
		6:
			spawn_delay = 0.05
			mob_cap = 200
			spawn_probability = [1.0 ,0.0 ,0.0 , 0.0, 0.5]
		7:
			spawn_probability = [0.0, 0.0 ,0.0 ,0.0 ,1.0]
		8:
			for mob in get_tree().get_nodes_in_group("mobs"):
				mob.queue_free()
			for projectile in get_tree().get_nodes_in_group("projectiles"):
				projectile.queue_free()
			active = false
			mob_cap = 0
			spawn_probability = [0.0,0.0,0.0,0.0,0.0]
			spawn_boss(0)
		9:
			active = false
			spawn_boss(1)

func spawn_boss(n):
	var b = bosses[n].instance()
	b.global_position = Vector2(player.global_position.x + 500, player.global_position.y)
	$Bosses.call_deferred("add_child", b)
	active = false

#Select which mob to spawn based on probability
#idea for improvement: make mobs spawn more frequently in the direction the player is heading
func rand_mob():
	var a = []
	var largest := 0.0
	var n = 0
	for i in range(spawn_probability.size()):
		a.append(spawn_probability[i] - rng.randf())
	for i in range(a.size()):
		if a[i] > largest:
			largest = a[i]
			n = i 
	return n

func get_random_position():
	var vpr = get_viewport_rect().size * rng.randf_range(1.1,1.4)
	var spawn_pos_1 = Vector2.ZERO
	var spawn_pos_2 = Vector2.ZERO
	var top_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2, player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2, player.global_position.y + vpr.y/2)
	
	match rng.randi_range(1,4):
		1: #up
			spawn_pos_1 = top_left
			spawn_pos_2 = top_right
		2: #down
			spawn_pos_1 = bottom_left
			spawn_pos_2 = bottom_right
		3: #right
			spawn_pos_1 = top_right
			spawn_pos_2 = bottom_right
		4: #left
			spawn_pos_1 = top_left
			spawn_pos_2 = bottom_left
	
	#return random position
	return Vector2(rng.randi_range(spawn_pos_1.x,spawn_pos_2.x),rng.randi_range(spawn_pos_1.y,spawn_pos_2.y))


func _on_CooldownTimer_timeout():
	active = true
