extends Node

var game_over = false
var environments = ["forest", "desert", "ocean", "cosmos"]
var current_environment = 0

var spawn = true

var mob = preload("res://mobs/Droid.tscn")

#var env_obj1 = $Environment.new()
#var env_obj2 = $Environment.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	game_over = false
	$Player.move_to($StartPosition.position)
	$Environment1.move(true)
	$Environment2.move(true)
	
func spawn_mob():
	var m = mob.instance()
	m.spawn($MobSpawnPoint.global_position)
	call_deferred("add_child", m)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if Input.is_action_pressed("ui_end"):
		#close window
		get_tree().quit()
		
	if game_over:
		$Player.defeat()
		$Environment1.move(false)
		$Environment2.move(false)
		#restart
		if get_tree().change_scene("res://Main.tscn") != 0:
			print("ERROR")
			get_tree().quit()
		return
	
	if spawn:
		spawn_mob()
		spawn = false
		
	if $Player.position.x < -20 or $Player.position.y > get_viewport().size.y:
		game_over = true
		print("game over")
