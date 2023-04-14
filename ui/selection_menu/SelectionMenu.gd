#This will handle saving and loading all the player data
extends Control

const SAVE_FILE = "user://save_file.res"
var game_data = {}

onready var lvl_selection_menu = $LevelSelectionMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	load_data()
	if game_data.first_time_playing:
		game_data.first_time_playing = false
		#play cutscene and show controls
	#show gold
	$VBoxContainer/TopBar/HBoxContainer/GoldDisplay/GoldCount.text = str(game_data.gold)
	
	#unlock levels
	if game_data.level1_completed:
		$LevelSelectionMenu.unlock_level_two()
	if game_data.level2_completed:
		$LevelSelectionMenu.unlock_level_three()


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
			#"endless_highscore" : 0,
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
	$VBoxContainer/MiddleContainer/CenterContainer2/Confirm/Clicked
	lvl_selection_menu.call_deferred("set_visible", true)
