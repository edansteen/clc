extends Control

var game_data = {}

enum levelOptions {ONE, TWO, THREE, NA}
var selected_level = levelOptions.NA

var icons = [
	preload("res://assets/sprites/mobArt/mobIcons/TrenchBotIcon.png"),
	preload("res://assets/sprites/mobArt/mobIcons/DestroyerBotIcon.png")
]

#load data
func _ready():
	$LevelMenu/HBoxContainer/LevelOne.unlock()
	$LevelMenu/HBoxContainer/LevelTwo/VBoxContainer/Icon.texture = icons[0]
	$LevelMenu/HBoxContainer/LevelTwo/VBoxContainer/Mode.text = "Medium"
	$LevelMenu/HBoxContainer/LevelThree/VBoxContainer/Icon.texture = icons[1]
	$LevelMenu/HBoxContainer/LevelThree/VBoxContainer/Mode.text = "Hard"

	if SaveScript.game_data.achievement1:
		$LevelMenu/HBoxContainer/LevelTwo.unlock()
	else:
		$LevelMenu/HBoxContainer/LevelTwo/Requirement.text = "Defeat a Bull in Easy mode to unlock"
	if SaveScript.game_data.achievement2:
		$LevelMenu/HBoxContainer/LevelThree.unlock()
	else:
		$LevelMenu/HBoxContainer/LevelThree/Requirement.text = "Defeat a Bull in Medium mode to unlock"

func play():
	SaveScript.save()
	#wait for data to save
	var error = get_tree().change_scene("res://game/Main.tscn")
	if error != OK:
		print("ERROR: scene could not load")

func _on_LevelOne_pressed():
	selected_level = levelOptions.ONE
	$LevelMenu/StartButton.set_deferred("disabled", false)

func _on_LevelTwo_pressed():
	selected_level = levelOptions.TWO
	$LevelMenu/StartButton.set_deferred("disabled", false)
	
func _on_LevelThree_pressed():
	selected_level = levelOptions.THREE
	$LevelMenu/StartButton.set_deferred("disabled", false)

func _on_StartButton_pressed():
	Globals.selectedLevel = selected_level
	play()


func _on_BackButton_pressed():
	$LevelMenu/StartButton.set_deferred("disabled", true)
