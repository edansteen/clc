#Script for saving and loading data.
#game_data is the dict used by all other parts of the game
extends Node

const SAVE_PATH = "user://userdata.save"
var game_data = {}

func _ready():
	game_data = load_data()

func save():
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	#game_data = dict
	file.store_line(to_json(game_data))
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
			 reset()
			 return
	file.open(SAVE_PATH, File.READ)
	var data = parse_json(file.get_as_text())
	
	if typeof(data) != TYPE_DICTIONARY or data == null: # Check that the data is valid
		print("Error. Corrupted data")
		return 1
		
	return data
	
func reset():
	game_data = {
		"highscore" : 0.0,
		"achievement1" : false,
		"achievement2" : false,
		"activeLevel" : 0,
		"oneUnlocked" : false, #BulletRetriever
		"twoUnlocked" : false, #Turtle
		"threeUnlocked" : false, #???
		"musicVolume" : 0.5,
		"sfxVolume" : 1
	}
	save()
	print("reset")
