extends Button

var is_disabled = true

func set_player_icon(s):
	$SpriteIcon.texture = s

func unlock():
	self.set_deferred("disabled", false)

func get_is_disabled():
	return is_disabled


func _on_CharacterButton_pressed():
	$Clicked.play()
