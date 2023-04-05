extends CanvasLayer

var game_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_end"):
		if get_tree().paused:
			if game_paused:
				unpause()
		else:
			get_tree().paused = true
			set_visible(true)
			game_paused = true
			$MenuOpened.play()
	
	
func set_visible(is_visible):
	for node in $VisualElements.get_children():
		node.visible = is_visible

func unpause():
	if game_paused:
		get_tree().paused = false
		game_paused = false
	set_visible(false)
	

func _on_Quit_pressed():
	unpause()
	get_tree().change_scene("res://TitleScreen.tscn")

func _on_Resume_pressed():
	unpause()

func _on_Button_pressed():
	pass
