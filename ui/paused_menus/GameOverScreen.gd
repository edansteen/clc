extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)


func make_visible(result):
	if result == true: #VICTORY!
		$PanelContainer/VBoxContainer/Title.text = str("You did it!")
		$ColorRect.color = Color(65,225,45,0.8)
	else:	#loss...
		var string = "Me-Ouch..." #default in case something goes wrong
		match RandomNumberGenerator.new().randi_range(0,3):
			0:
				pass #leave it as default
			1:
				string = "Tough luck champ..."
			2:
				string = "At least you have 9 lives..."
			3:
				string = "You died."
		$PanelContainer/VBoxContainer/Title.text = string
	get_tree().paused = true
	set_visible(true)


func _on_Play_Again_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://levels/level_one/LevelOne.tscn")


func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen.tscn")
