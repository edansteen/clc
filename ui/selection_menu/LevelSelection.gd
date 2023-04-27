extends Control

var game_data = {}

enum levelOptions {NA, ONE, TWO, THREE}
var selected_level = levelOptions.NA

var save_path = preload("res://ui/SaveScript.gd")
var SaveObject = null

#load data
func _ready():
	SaveObject = save_path.new()
	game_data = SaveObject.load_data()
	#play starting cutscene if first time playing
	if game_data.first_time_playing:
		print("Played for the first time")
		game_data.first_time_playing = false
	
	#unlock levels based on loaded data
	$LevelMenu/HBoxContainer/LevelOne.unlock()
	if game_data.achievement1:
		$LevelMenu/HBoxContainer/LevelTwo.unlock()
	if game_data.achievement2:
		$LevelMenu/HBoxContainer/LevelThree.unlock()

func play():
	SaveObject.save(game_data)
	var error = get_tree().change_scene("res://game/endless/Endless.tscn")
	if error != OK:
		print("ERROR: scene could not load")

func _on_LevelOne_pressed():
	if selected_level != levelOptions.ONE:
		selected_level = levelOptions.ONE
	else:
		game_data.selectedLevel = levelOptions.ONE
		play()

func _on_LevelTwo_pressed():
	if selected_level != levelOptions.TWO:
		selected_level = levelOptions.TWO
	else:
		game_data.selectedLevel = levelOptions.TWO
		play()
	
func _on_LevelThree_pressed():
	if selected_level != levelOptions.THREE:
		selected_level = levelOptions.THREE
	else:
		game_data.selectedLevel = levelOptions.THREE
		play()


func _on_Button_pressed():
	SaveObject.reset()
