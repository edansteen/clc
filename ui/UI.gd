extends CanvasLayer

export var score = 0
var time = 0
export var fish_count = 0

var seconds = 0
var minutes = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	time = 0
	fish_count = 0

func set_time(t):
	time = t
	$Control/TimeDisplay.text = str(round(time)) + ":" + str(round(time)) 

func get_score():
	return score

func add_fish(n):
	fish_count+=n
	$Control/FishDisplay.text = str(fish_count)

func get_fish_count():
	return fish_count
