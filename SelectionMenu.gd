#This will handle saving and loading all the player data
extends Control

const SAVE_FILE = "user://save_file.res"

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
	if ResourceLoader.exists(SAVE_FILE):
		game_data = ResourceLoader.load(SAVE_FILE)
		if typeof(game_data) != TYPE_DICTIONARY: # Check that the data is valid
			print("Error. Corrupted data")
			return 1
	else:
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
	

func save_data():
	var result = ResourceSaver.save(SAVE_FILE, game_data)
	assert(result == OK)


func _on_BackButton_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")


func _on_Confirm_pressed():
	get_tree().change_scene("res://Main.tscn")
