extends Node2D

#maximum number of mobs that can be spawned
export var mob_cap: int = 10
export var spawn_rate = 1	#in mobs per second
export var active: bool = false

var max_spawn_distance = 1000

onready var player = get_tree().get_nodes_in_group("player")[0]

var rng := RandomNumberGenerator.new()
#preload of all mobs
var mobs = [preload("res://mobs/Mob.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	active = false
	spawn_rate = 1
	
func _process(_delta):
	if active:
		while $Mobs.get_child_count() < mob_cap:
			for _i in range(spawn_rate):
				spawn_mob()
		active = false
		$CooldownTimer.start(1) #1 second pause

func set_active(b):
	active = b

func set_spawn_rate(r):
	spawn_rate = r

func spawn_mob():
	var m = mobs[0].instance()
# warning-ignore:narrowing_conversion
	m.global_position = player.global_position + Vector2(max_spawn_distance,0).rotated(rng.randi_range(0, 2*PI))
	$Mobs.call_deferred("add_child", m)


func _on_CooldownTimer_timeout():
	active = true
