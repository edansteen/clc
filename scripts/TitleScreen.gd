extends Control


func _ready():
	$TitleMusic.play()

func _on_Play_pressed():
	$LevelSelectionMenu.call_deferred("set_visible", true)

func _on_Options_pressed():
	$OptionsMenu.call_deferred("set_visible", true)


func _on_Quit_pressed():
	get_tree().quit()
