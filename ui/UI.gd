extends CanvasLayer

export var score = 0
export var fish_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	fish_count = 0

func set_score(s):
	score = s
	$Control/ScoreDisplay.text = "%s" % str(round(score))

func get_score():
	return score

func add_fish():
	fish_count+=1
	$Control/FishDisplay.text = str(fish_count)

func get_fish_count():
	return fish_count
