extends Control

const SAVE_FILE = "user://save_file.res"
var game_data ={}

enum levelOptions {NA, ONE, TWO, THREE}
var selected_level = levelOptions.NA


#load data
func _ready():
	if ResourceLoader.exists(SAVE_FILE):
		game_data = ResourceLoader.load(SAVE_FILE)
		if typeof(game_data) != TYPE_DICTIONARY: # Check that the data is valid
			print("Error. Corrupted data")
			return 1
	else:
		game_data =  {
			"first_time_playing" : true,
			#"endless_highscore" : 0,
			"level1_completed" : false,
			"level2_completed" : false,
			"level3_completed" : false
		}
		
		#play starting cutscene if first time playing
		if game_data.first_time_playing:
			#do things
			pass
	
	#unlock levels based on loaded data
	$LevelMenu/HBoxContainer/LevelOne.unlock()
	if game_data.level1_completed:
		$LevelMenu/HBoxContainer/LevelTwo.unlock()
	if game_data.level2_completed:
		$LevelMenu/HBoxContainer/LevelThree.unlock()

func get_level_description(lvl):
	$LevelDescription.set_deferred("visible", true)
	
	match lvl:
		levelOptions.ONE:
			return "The robot army has taken over the city. Luckily, one cat in particular is on the scene..."
		levelOptions.TWO:
			return "Upon its defeat, the Mechanical Bull unleashed a signal, which the cat followed. It led to a bridge—one that seemed to go on forever...."
		levelOptions.THREE:
			return "The cat followed the portal left by the Mechanical Worm, leading to some mysterious lair. But who does it belong to?"
		levelOptions.NA:
			return "What have we here?"

func _on_LevelOne_pressed():
	if selected_level != levelOptions.ONE:
		selected_level = levelOptions.ONE
	else:
		get_tree().change_scene("res://levels/level_one/LevelOne.tscn")


func _on_LevelTwo_pressed():
	if selected_level != levelOptions.TWO:
		selected_level = levelOptions.TWO
	else:
		get_tree().change_scene("res://Main.tscn")


func _on_LevelThree_pressed():
	if selected_level != levelOptions.THREE:
		selected_level = levelOptions.THREE
	else:
		get_tree().change_scene("res://Main.tscn")
