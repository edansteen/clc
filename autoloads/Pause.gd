extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_end"):
		var reverse_state = !get_tree().paused
		get_tree().paused = reverse_state #toggle pause
		set_visible(reverse_state)
	
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible

func _on_Quit_pressed():
	get_tree().quit()

func _on_Resume_pressed():
	get_tree().paused = false
	set_visible(false)
