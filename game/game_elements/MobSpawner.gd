extends Node2D

export var active: bool = false

#difficulty level
var difficulty = Globals.selectedLevel
var mob_cap: int = 50 #maximum number of mobs that can be spawned
var spawn_delay: float = 1.0 #in s
var max_distance = 3000.0
onready var player = get_tree().get_nodes_in_group("player")[0]

var rng := RandomNumberGenerator.new()

#preload of all mobs
var mobs = [
	preload("res://game/game_elements/mobs/Droid.tscn"),
	preload("res://game/game_elements/mobs/Boombot.tscn"),
	preload("res://game/game_elements/mobs/ThreeBotsInTrenchCoat.tscn"),
	preload("res://game/game_elements/mobs/DestroyerBot.tscn"),
	preload("res://game/game_elements/mobs/Droid.tscn")
]

var blaster = preload("res://game/game_elements/mobs/mob_projectiles/DroidBlaster.tscn")

# Probability of spawning mob measured as a float from 0 to 1. 
#spawn_probability[0] refers to probability of spawning the mob at mobs[0] (which would be the droid)
var spawn_probability = [1.0, 0.0, 0.0, 0.0, 0.0]

#preload all bosses
var bosses = [
	preload("res://game/game_elements/mobs/bosses/BullBoss/RoboBull.tscn"),
	preload("res://game/game_elements/mobs/bosses/SnakeBoss/SnakeHead.tscn")
]

# Called when the node enters the scene tree for the first time.
func _ready():
	active = false
	set_level(1)


func _process(_delta):
	if active and $Mobs.get_child_count() < mob_cap:
		#spawn mobs
		var rand = rand_mob()
		var m = mobs[rand].instance()
		if rand == 5:
			m.call_deferred("add_child", blaster.instance())
		m.global_position = get_random_position()
		$Mobs.call_deferred("add_child", m)
		active = false
		$CooldownTimer.start(spawn_delay)
	
	var p_pos = player.global_position
	for mob in $Mobs.get_children():
		if mob.global_position.distance_to(p_pos) > max_distance:
			mob.queue_free()

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
			spawn_probability = [0.1, 0.8, 0.9, 0.0, 0.0]
		5:
			spawn_delay = 0.1
			mob_cap = 150
			spawn_probability = [1.0,1.0,1.0,0.1, 0.0]
		6:
			spawn_delay = 0.05
			mob_cap = 200
			spawn_probability = [1.0 ,0.0 ,0.0 , 0.5, 0.0]
		7:
			spawn_probability = [0.0, 0.0 ,0.0 ,0.9, 0.1]
		8:
			spawn_probability = [1.0,0.0,0.0,0.0,0.0]
			spawn_boss(0)
		9: #spawn mobs at random
			spawn_probability = [1.0,1.0,1.0,1.0,1.0]
			mob_cap += 20
			if spawn_delay >= 0.01:
				spawn_delay /= 1.2

func spawn_boss(n):
	var b = bosses[n].instance()
	b.global_position = get_random_position()
	$Bosses.call_deferred("add_child", b)

#Select which mob to spawn based on probability
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

#idea for improvement: make mobs spawn more frequently in the direction the player is heading
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

func boss_defeated():
	mob_cap = 200
	set_level(9)
	Globals.bullsDefeated += 1

func end_game():
	$CooldownTimer.stop()
	for m in get_tree().get_nodes_in_group("mobs"):
			m.queue_free() 
	spawn_probability = [0.0,0.0,0.0,1.0,0.0]
	mob_cap = 250
	spawn_delay = 0.05
	$CooldownTimer.start(spawn_delay)
	
func _on_CooldownTimer_timeout():
	active = true
