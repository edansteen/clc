#This will handle saving and loading all the player data
extends Control

const SAVE_FILE = "user://save_file.save"

var game_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	if game_data.first_time_playing:
		game_data.first_time_playing = false
		#play cutscene and show controls
	#show gold
	$VBoxContainer/TopBar/GoldDisplay/GoldCount.text = str(game_data.gold)

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		game_data =  {
			"first_time_playing" : true,
			"gold" : 0,
			"endless_highscore" : 0,
			"rambocat_unlocked" : false,
			"jotarocat_unlocked" : false,
			"level1_completed" : false,
			"level2_completed" : false,
			"level3_completed" : false
		}
	else:
		file.open(SAVE_FILE,File.READ)
		game_data = file.get_var()
		file.close()
	

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()

