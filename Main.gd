extends Node

var game_over = false
var environments = ["forest", "desert", "ocean", "cosmos"]
var current_environment = 0

#var env_obj1 = $Environment.new()
#var env_obj2 = $Environment.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over = false
	$Player.move_to($StartPosition.position)
	$Environment.move(true)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if game_over:
		$Player.defeat()
		$Environment.move(false)
		return

	if $Player.position.x < -20 or $Player.position.y > get_viewport().size.y:
		game_over = true
		print("game over")
