extends CanvasLayer

var xp_level = 1
var xp_progress = 0 #percentage of progress to next level

var active_hearts = 3

onready var heart_container = $Control/HeartContainer
onready var xp_bar = $Control/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	xp_level = 1
	xp_progress = 0


func add_xp(xp, xp_to_next_level, level):
	xp_bar.max_value = xp_to_next_level
	xp_bar.value = xp
	xp_level = level


func set_hearts(n):
	active_hearts = n

