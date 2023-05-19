# Option 0 = Wizard
# Option 1 = RamboCat
# Option 2 = Turtle
# Option 3 = ???? 
extends Control

var save_path = preload("res://scripts/SaveScript.gd")
var SaveObject = null
var loaded_data = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	SaveObject = save_path.new()
	loaded_data = SaveObject.load_data()
	for button in $VBoxContainer/HBoxContainer/Characters/GridContainer.get_children():
		pass

func selectOption(n):
	var name = ""
	var details = ""
	var desc = ""
	match (n):
		0: #Cat
			pass
		1: #Wizard
			name = "The Naked Wizard"
			details = "100 HP, 200 Speed. Magic Missile lvl. 1"
			desc = "The naked wizard's home was attacked while he was taking a shower. He seeks vengeance."
		2: # BulletRetriever
			name = "Bullet Retriever"
			details = "120hp, 180 Speed. Magic Gun lvl 3."
			desc = "This dawg of a dog's owner is an ex US. Navy Seal. Trigger & Happy are his middle names."
		3: #Turtle
			pass
		4: #???
			pass
	$VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CenterContainer/Sprite.play(str(n))
	loaded_data.selectedChar = n
	SaveObject.save(loaded_data)
