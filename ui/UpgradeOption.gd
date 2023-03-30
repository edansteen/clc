extends Button

#index value
var value = -1

func set_value(n):
	value = n
	
func get_value():
	return value

func set_option(weapon_object):
	$VBoxContainer/HBoxContainer/Icon.texture = load(weapon_object.get_icon())
	$VBoxContainer/HBoxContainer/Name.text = weapon_object.get_name()
	var level = weapon_object.get_level()
	if level == 0:
		$VBoxContainer/HBoxContainer/LevelIndicator.text = "(New!)"
	else:
		$VBoxContainer/HBoxContainer/LevelIndicator.text = "Level:" + str(level+1)
	$VBoxContainer/Description.text = weapon_object.get_desc()
