extends Node

var environments = ["forest", "desert", "ocean", "cosmos"]
var current_environment = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.move_to($StartPosition.position)
	$Environment.move(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
