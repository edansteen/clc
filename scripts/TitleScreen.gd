#shaq is not a shart, also Gabs was here
extends Control

func _ready():
	$TitleMusic.play()

func _on_Play_pressed():
	$CharacterSelection.call_deferred("set_visible", true)

func _on_Options_pressed():
	$OptionsMenu.call_deferred("set_visible", true)

func _on_Quit_pressed():
	get_tree().quit()
	JavaScript.eval("window.close()")

func _on_CharacterSelection_confirmed():
	$LevelSelectionMenu.set_deferred("visible", true)
