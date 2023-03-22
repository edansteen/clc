extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)

func make_visible():
	set_visible(true)


func _on_Play_Again_pressed():
	get_tree().change_scene("res://Main.tscn")


func _on_Quit_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")
