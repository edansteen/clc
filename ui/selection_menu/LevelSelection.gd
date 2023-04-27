extends Control

const SAVE_PATH = "user://userdata.save"

var game_data = {}

enum levelOptions {NA, ONE, TWO, THREE}
var selected_level = levelOptions.NA


#load data
func _ready():
	if ResourceLoader.exists(SAVE_PATH):
		game_data = ResourceLoader.load(SAVE_PATH)
		if typeof(game_data) != TYPE_DICTIONARY: # Check that the data is valid
			print("Error. Corrupted data")
			return 1
	else:
		game_data = {
			"first_time_playing" : true,
			"highscore" : 0,
			"achievement1" : false,
			"achievement2" : false,
			"musicVolume" : 0.5,
			"sfxVolume" : 0.5
		}
		
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

func save_data():
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	file.store_line(to_json(game_data))
	file.close()
	print(game_data)
	
func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
			 save_data()
			 return
	file.open(SAVE_PATH, File.READ)
	var game_data = parse_json(file.get_as_text())
	
	if typeof(game_data) != TYPE_DICTIONARY: # Check that the data is valid
		print("Error. Corrupted data")
		return 1

func play():
	save_data()
	var error = get_tree().change_scene("res://game/endless/Endless.tscn")
	if error != OK:
		print("ERROR: scene could not load")

func _on_LevelOne_pressed():
	if selected_level != levelOptions.ONE:
		selected_level = levelOptions.ONE
	else:
		play()

func _on_LevelTwo_pressed():
	if selected_level != levelOptions.TWO:
		selected_level = levelOptions.TWO
	else:
		play()
	
func _on_LevelThree_pressed():
	if selected_level != levelOptions.THREE:
		selected_level = levelOptions.THREE
	else:
		play()


func _on_Button_pressed():
	game_data = {
		"first_time_playing" : true,
		"highscore" : 0,
		"achievement1" : false,
		"achievement2" : false,
		"musicVolume" : 0.5,
		"sfxVolume" : 0.5
	}
	save_data()
