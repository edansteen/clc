extends Control

const SAVE_FILE = "user://save_file.res"
var game_data ={}

enum levelOptions {NA, ONE, TWO, THREE}
var selected_level = levelOptions.NA


#load data
func _ready():
	pass
	#make level 2 and 3 available based on the loaded data

func get_level_description(lvl):
	match lvl:
		levelOptions.ONE:
			return "The robot army has taken over the city. Luckily, one cat in particular is on the scene..."
		levelOptions.TWO:
			return "Upon its defeat, the Mechanical Bull unleashed a signal, which the cat followed. It led to a bridge—one that seemed to go on forever...."
		levelOptions.THREE:
			return "The cat followed the portal left by the Mechanical Worm, leading to some mysterious lair. But who does it belong to?"
		levelOptions.NA:
			return "What have we here?"

#unlock levels
func unlock_level_two():
	$LevelMenu/HBoxContainer/LevelTwo/Lock.queue_free()

func unlock_level_three():
	$LevelMenu/HBoxContainer/LevelThree/Lock.queue_free()

func _on_Back_pressed():
	self.set_deferred("visible", false)


func _on_LevelOne_pressed():
	if selected_level != levelOptions.ONE:
		selected_level = levelOptions.ONE
	else:
		get_tree().change_scene("res://Main.tscn")


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
