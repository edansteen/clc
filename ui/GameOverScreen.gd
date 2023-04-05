extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)

func make_visible(result):
	if result == true: #VICTORY!
		$PanelContainer/MarginContainer/VBoxContainer/Title.text = "Good job!"
	else:	#loss...
		$PanelContainer/MarginContainer/VBoxContainer/Title.text = "Me-Ouch..."
	get_tree().paused = true
	set_visible(true)
	

func _on_Play_Again_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Main.tscn")


func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen.tscn")
