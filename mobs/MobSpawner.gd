extends Node2D

#maximum number of mobs that can be spawned
export var mob_cap: int = 50
export var spawn_delay: float = 2.0 #in s
export var active: bool = false

var max_spawn_distance = 1000

onready var player = get_tree().get_nodes_in_group("player")[0]

var rng := RandomNumberGenerator.new()

#preload of all mobs
var mobs = preload("res://mobs/Mob.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	active = false
	spawn_delay = 2.0
	
func _process(_delta):
	if active and $Mobs.get_child_count() < mob_cap:
		#spawn mobs
		var m = mobs.instance()
		m.global_position = get_random_position()
		$Mobs.call_deferred("add_child", m)
		active = false
		$CooldownTimer.start(spawn_delay)

func set_active(b):
	active = b

func set_spawn_delay(s):
	spawn_delay = s

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
