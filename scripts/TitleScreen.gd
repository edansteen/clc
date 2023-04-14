extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Play_pressed():
	$LevelSelectionMenu.call_deferred("set_visible", true)



func _on_Options_pressed():
	$Menu/CenterRow/Buttons/Options/Clicked.play()


func _on_Quit_pressed():
	get_tree().quit()
