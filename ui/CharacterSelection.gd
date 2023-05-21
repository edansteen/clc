# Option 0 = Wizard
# Option 1 = RamboCat
# Option 2 = Turtle
# Option 3 = ???? 
extends Control

signal confirmed

var save_path = preload("res://scripts/SaveScript.gd")
var SaveObject = null
var loaded_data = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	SaveObject = save_path.new()
	loaded_data = SaveObject.load_data()
	#var buttons = $VBoxContainer/HBoxContainer/Characters/GridContainer.get_children()
	#buttons[0].set_player_icon("") #wizard
	print(loaded_data.selectedCharacter)
	selectOption(loaded_data.selectedCharacter)

func selectOption(n):
	var name = ""
	var details = ""
	var desc = ""
	match (n):
		0: #Wizard
			name = "The Naked Wizard"
			details = "HP: 100, Speed: 200, Magic Missile lvl. 1"
			desc = "The naked wizard's home was attacked while he was taking a shower. He seeks vengeance."
		1: # BulletRetriever
			name = "Bullet Retriever"
			details = "HP: 120 Speed: 180, Magic Gun lvl. 3"
			desc = "This dawg of a dog's owner is an ex US. Navy Seal. Trigger & Happy are his middle names."
		2: #Turtle
			name = "Mutated Turtle"
			details = "HP: 200, Speed: 130, Force Field lvl. 1"
			desc = "After having radioactive goo spilled on it as a baby, this turtle mutated into... a regular adult mutant turtle...."
		3: #???
			name = "???"
			details = "HP: 1, Speed: 300, Cosmic Orbs lvl. 6"
			desc = "A being of cosmic origin. Even the Gods quake in it's presence."
	$VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CenterContainer/Sprite.play(str(n))
	$VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CharacterBios/VBoxContainer/Name.text = name
	$VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CharacterBios/VBoxContainer/Details.text = details
	$VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CharacterBios/VBoxContainer/Description.text = desc
	loaded_data.selectedCharacter = n


func _on_ConfirmButton_pressed():
	SaveObject.save(loaded_data)
	emit_signal("confirmed")


func _on_CharacterButton_pressed():
	selectOption(0)

func _on_CharacterButton2_pressed():
	selectOption(1)

func _on_CharacterButton3_pressed():
	selectOption(2)

func _on_CharacterButton4_pressed():
	selectOption(3)
