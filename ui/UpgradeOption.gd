extends Button

#index value
var value = -1

func set_value(n):
	value = n
	
func get_value():
	return value

func set_option(weapon_object):
	if weapon_object == null:
		value = -1
		$VBoxContainer/HBoxContainer/Icon.texture = load("res://assets/sprites/heart_sprite.png")
		$VBoxContainer/HBoxContainer/Name.text = "Heal"
		$VBoxContainer/HBoxContainer/LevelIndicator.text = "(Powerup)"
		$VBoxContainer/Description.text = "Heal for 40 hp"
	else:
		$VBoxContainer/HBoxContainer/Icon.texture = load(weapon_object.get_icon())
		$VBoxContainer/HBoxContainer/Name.text = weapon_object.get_name()
		var level = weapon_object.get_level()
		if level == 0:
			$VBoxContainer/HBoxContainer/LevelIndicator.text = "(New!)"
		else:
			$VBoxContainer/HBoxContainer/LevelIndicator.text = "Level:" + str(level+1)
		$VBoxContainer/Description.text = weapon_object.get_desc()
