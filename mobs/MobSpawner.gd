extends Node2D

export var active: bool = false

var max_spawn_distance = 1000

#difficulty level
var level = 1 
var mob_cap: int = 50 #maximum number of mobs that can be spawned
var spawn_delay: float = 1.0 #in s

onready var player = get_tree().get_nodes_in_group("player")[0]

var rng := RandomNumberGenerator.new()

#preload of all mobs
var mobs = [
	preload("res://mobs/Droid.tscn"),
	preload("res://mobs/Boombot.tscn")
]

# Probability of spawning mob measured as a float from 0 to 1. 
#spawn_probability[0] refers to probability of spawning the mob at mobs[0] (which would be the droid)
var spawn_probability = [1.0, 0.0]

#preload all bosses
var bosses = []

# Called when the node enters the scene tree for the first time.
func _ready():
	active = false
	level = 1


func _process(_delta):
	match level:
		1:
			spawn_delay = 1.0
			mob_cap = 50
			spawn_probability = [1.0, 0.0]
		2: 
			spawn_delay = 0.5
			mob_cap = 80
			spawn_probability = [0.8, 0.2]

	if active and $Mobs.get_child_count() < mob_cap:
		#spawn mobs
		#decide which mob to spawn
		
		var m = mobs[rand_mob()].instance()
		m.global_position = get_random_position()
		$Mobs.call_deferred("add_child", m)
		active = false
		$CooldownTimer.start(spawn_delay)


func set_active(b):
	active = b

func set_level(n):
	level = n

#Select which mob to spawn based on probability
func rand_mob():
	for i in range(1, spawn_probability.size()):
		if (spawn_probability[i] - rng.randf()) > (spawn_probability[i-1] - rng.randf()):
			return i
	return 0

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
