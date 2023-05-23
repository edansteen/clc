extends Button

var unlocked = false

func set_player_icon(s):
	$SpriteIcon.texture = s

func unlock():
	unlocked = true

func is_unlocked():
	return unlocked


func _on_CharacterButton_pressed():
	$Clicked.play()
