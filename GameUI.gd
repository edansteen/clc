extends Control

export var score = 0
export var fish_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	fish_count = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ScoreDisplay.text = "%sm" % str(round(score))
	$FishDisplay.text = str(fish_count)
	score += delta

func get_score():
	return score

func add_fish():
	fish_count+=1

func get_fish_count():
	return fish_count
