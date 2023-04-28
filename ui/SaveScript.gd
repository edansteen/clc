extends Node

const SAVE_PATH = "user://userdata.save"
var game_data = {}

func save(dict):
	var file = File.new()
	file.open(SAVE_PATH, File.WRITE)
	game_data = dict
	file.store_line(to_json(game_data))
	file.close()
	print(game_data)


func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
			 reset()
			 return
	file.open(SAVE_PATH, File.READ)
	game_data = parse_json(file.get_as_text())
	
	if typeof(game_data) != TYPE_DICTIONARY or game_data == null: # Check that the data is valid
		print("Error. Corrupted data")
		return 1
		
	return game_data
	
func reset():
	var d = {
		"first_time_playing" : true,
		"highscore" : 0.0,
		"achievement1" : false,
		"achievement2" : false,
		"activeLevel" : 0,
		"musicVolume" : 0.5,
		"sfxVolume" : 0.5
	}
	save(d)
	print("wiped")
