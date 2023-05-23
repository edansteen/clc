extends Button

var rainbow = preload("res://assets/shaders/Rainbow.gdshader")
#index value
var value = -1

func set_value(n):
	value = n
	
func get_value():
	return value

func set_option(weapon_object):
	if weapon_object == null:
		var valid = false
		while(!valid):
			var n = randf()
			if (n < 0.4) and !Globals.powerupsShown[0]:
				value = -1
				$VBoxContainer/HBoxContainer/Icon.texture = load("res://assets/sprites/heart_sprite.png")
				$VBoxContainer/HBoxContainer/Name.text = "Heal"
				$VBoxContainer/HBoxContainer/LevelIndicator.text = "(Powerup)"
				$VBoxContainer/Description.text = "Heal for 40 hp"
				valid = true
			elif n >= 0.4 and n < 7 and !Globals.powerupsShown[1]:
				value = -2
				$VBoxContainer/HBoxContainer/Icon.texture = load("res://assets/sprites/wingIcon.png")
				$VBoxContainer/HBoxContainer/Name.text = "Speed Boost"
				$VBoxContainer/HBoxContainer/LevelIndicator.text = "(Powerup)"
				$VBoxContainer/Description.text = "+20 Speed"
				valid = true
			elif n >= 7 and !Globals.powerupsShown[2]:
				value = -3
				$VBoxContainer/HBoxContainer/Icon.texture = load("res://assets/sprites/roboflex.png")
				$VBoxContainer/HBoxContainer/Name.text = "Damage Boost"
				$VBoxContainer/HBoxContainer/LevelIndicator.text = "(Powerup)"
				$VBoxContainer/Description.text = "+10% Damage"
				valid = true
	else:
		$VBoxContainer/HBoxContainer/Icon.texture = load(weapon_object.get_icon())
		$VBoxContainer/HBoxContainer/Name.text = weapon_object.get_name()
		var level = weapon_object.get_level()
		$VBoxContainer/HBoxContainer/Name.add_color_override("font_color", Color("ffffff"))
		if level == 0:
			$VBoxContainer/HBoxContainer/LevelIndicator.text = "(New!)"
		elif level >= 5:
			$VBoxContainer/HBoxContainer/LevelIndicator.text = "(MAX!)"
			$VBoxContainer/HBoxContainer/Name.add_color_override("font_color", Color("ffdd00"))
		else:
			$VBoxContainer/HBoxContainer/LevelIndicator.text = "Level:" + str(level+1)
		
		$VBoxContainer/Description.text = weapon_object.get_desc()


func _on_UpgradeOption_pressed():
	$VBoxContainer/HBoxContainer/Name.add_color_override("font_color", Color("ffffff"))
	Globals.powerupsShown = [false,false,false]
