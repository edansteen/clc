extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Play_pressed():
	get_tree().change_scene("res://ui/selection_menu/SelectionMenu.tscn")



func _on_Options_pressed():
	$Menu/CenterRow/Buttons/Options/AudioStreamPlayer.play()


func _on_Quit_pressed():
	get_tree().quit()
