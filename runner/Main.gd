extends Node

export (int) var distance = 0

var game_over = false
var game_speed = 4


# Called when the node enters the scene tree for the first time.
func _ready():
	game_over = false
	game_speed = 4
	$Player.spawn()
	$Environment1.move(true)
	$Environment2.move(true)
	set_game_speed(game_speed)


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if game_over:
		$Environment1.move(false)
		$Environment2.move(false)
		#restart
		if get_tree().change_scene("res://runner/Main.tscn") != 0:
			print("ERROR")
			get_tree().quit()
		return
	
	distance = $Environment1.get_distance()
	$GameUI.set_score(distance)
	
	if distance > 100:
		if distance > 250:
			if distance > 500:
				if distance >= 1000:
					print("good job!")
					game_over = true	##victory
				else:
					set_game_speed(10)
			else:
				set_game_speed(8)
		else:
			set_game_speed(6)
	
	if $Player.is_hit:
		game_over = true

func set_game_speed(s):
	$Environment1.set_speed(s)
	$Environment2.set_speed(s)
