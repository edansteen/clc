extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)

func make_visible(result):
	if result == true: #VICTORY!
		$PanelContainer/MarginContainer/VBoxContainer/Title.text = "Good job!"
	else:	#loss...
		var string = "Me-Ouch..." #default in case something goes wrong
		match RandomNumberGenerator.new().randi_range(0,2):
			0:
				pass #leave it as default
			1:
				string = "Tough luck champ..."
			2:
				string = "At least you have 9 lives..."
		$PanelContainer/MarginContainer/VBoxContainer/Title.text = string
	get_tree().paused = true
	set_visible(true)
	

func _on_Play_Again_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Main.tscn")


func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen.tscn")
