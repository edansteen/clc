extends Node2D

#maximum number of mobs that can be spawned
export var mob_cap: int = 1000
export var spawn_rate = 1	#in mobs per second
export var active: bool = false

var rng := RandomNumberGenerator.new()
#preload of all mobs
var mobs = [preload("res://mobs/Mob.tscn")]

# Called when the node enters the scene tree for the first time.
func _ready():
	active = false	
	
func _process(_delta):
	pass

func set_active(b):
	active = b

func set_spawn_rate(r):
	spawn_rate = r

func spawn_mob():
	var m = mobs[0].instance()
# warning-ignore:narrowing_conversion
	m.position = $SpawnPoint.position + Vector2(2000,0).rotated(rng.randi_range(0, 2*PI))
	$Mobs.call_deferred("add_child", m)
