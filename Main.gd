extends Node

var game_over = false
var game_speed = 2

#var env_obj1 = $Environment.new()
#var env_obj2 = $Environment.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over = false
	game_speed = 2
	$Player.move_to($StartPosition.position)
	$Environment1.move(true)
	$Environment2.move(true)
	set_game_speed(game_speed)
	
#func spawn_mob():
#	var m = mob.instance()
#	m.spawn($MobSpawnPoint.global_position)
#	call_deferred("add_child", m)
	
# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if game_over:
		$Player.defeat()
		$Environment1.move(false)
		$Environment2.move(false)
		#restart
		if get_tree().change_scene("res://Main.tscn") != 0:
			print("ERROR")
			get_tree().quit()
		return
	
	if $Player.position.x < -20 or $Player.position.y > get_viewport().size.y:
		game_over = true
		print("game over")

func set_game_speed(s):
	$Environment1.set_speed(s)
	$Environment2.set_speed(s)
