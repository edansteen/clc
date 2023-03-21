extends Node

export var time = 0.0 #in s
export var time_till_boss = 5*60

# Called when the node enters the scene tree for the first time.
func _ready():
	$MobSpawner.set_active(true)
	time = 0.0
	$Music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta

func get_time():
	return time
