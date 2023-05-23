#Character Selection Script
extends Control

signal confirmed

var characterIcons = [
	preload("res://assets/sprites/playerSprites/characterIcons/wizardIcon.png"),
	preload("res://assets/sprites/playerSprites/characterIcons/bulletRetrieverIcon.png"),
	preload("res://assets/sprites/playerSprites/characterIcons/turtleIcon.png"),
	preload("res://assets/sprites/playerSprites/characterIcons/unknownIcon.png")
]

onready var buttons = $VBoxContainer/HBoxContainer/Characters/GridContainer.get_children()
onready var sprite = $VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CenterContainer/Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	buttons[0].set_player_icon(characterIcons[0])
	if SaveScript.game_data.oneUnlocked:
		buttons[1].unlock()
		buttons[1].set_player_icon(characterIcons[1])
		
	if SaveScript.game_data.twoUnlocked:
		buttons[2].unlock()
		buttons[2].set_player_icon(characterIcons[2])
		
	if SaveScript.game_data.threeUnlocked:
		buttons[3].unlock()
		buttons[3].set_player_icon(characterIcons[3])
			
	var n = Globals.selectedCharacter
	selectOption(n)
	

func selectOption(n):
	var name = ""
	var details = ""
	var desc = ""
	match (n):
		0: #Wizard
			sprite.material.set_shader_param("flashState",0)
			name = "The Naked Wizard"
			details = "HP: 100, Speed: 200, Magic Missile lvl. 1"
			desc = "The naked wizard's home was attacked while he was taking a shower. He seeks vengeance. And clothes."
		1: # BulletRetriever
			if SaveScript.game_data.oneUnlocked:
				sprite.material.set_shader_param("flashState",0)
				name = "Bullet Retriever"
				details = "HP: 120 Speed: 180, Magic Gun lvl. 2"
				desc = "This dawg of a dog's owner was an ex U.S. Navy Seal. His K.D. ratio is over 3000."
			else:
				sprite.material.set_shader_param("flashState",1)
				name = "???"
				details = "LOCKED"
				desc = "Max out Magic Gun to unlock"
		2: #Turtle
			if SaveScript.game_data.twoUnlocked:
				sprite.material.set_shader_param("flashState",0)
				name = "Mutated Turtle"
				details = "HP: 200, Speed: 130, Force Field lvl. 1"
				desc = "After having radioactive goo spilled on it as a baby, this turtle mutated into... a regular adult mutant turtle...."
			else:
				sprite.material.set_shader_param("flashState",1)
				name = "???"
				details = "LOCKED"
				desc = "Max out Force Field to unlock."
		3: #???
			if SaveScript.game_data.threeUnlocked:
				sprite.material.set_shader_param("flashState",0)
				name = "The Unknown"
				details = "HP: 1, Speed: 300, Cosmic Orbs lvl. 6"
				desc = "A being of cosmic origin. Even the Gods quake in it's presence."
			else:
				sprite.material.set_shader_param("flashState",1)
				name = "???"
				details = "LOCKED"
				desc = "Max out Cosmic Orbs to unlock"
	$VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CenterContainer/Sprite.play(str(n))
	$VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CharacterBios/VBoxContainer/Name.text = name
	$VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CharacterBios/VBoxContainer/Details.text = details
	$VBoxContainer/HBoxContainer/CharacterDisplay/VBoxContainer/CharacterBios/VBoxContainer/Description.text = desc
	Globals.selectedCharacter = n


func _on_ConfirmButton_pressed():
	emit_signal("confirmed")

func _on_CharacterButton_pressed():
	selectOption(0)
	$VBoxContainer/HBoxContainer/Characters/ConfirmButton.set_deferred("disabled", false)

func _on_CharacterButton2_pressed():
	selectOption(1)
	if $VBoxContainer/HBoxContainer/Characters/GridContainer/CharacterButton2.unlocked:
		$VBoxContainer/HBoxContainer/Characters/ConfirmButton.set_deferred("disabled", false)
	else:
		$VBoxContainer/HBoxContainer/Characters/ConfirmButton.set_deferred("disabled", true)

func _on_CharacterButton3_pressed():
	selectOption(2)
	if $VBoxContainer/HBoxContainer/Characters/GridContainer/CharacterButton3.unlocked:
		$VBoxContainer/HBoxContainer/Characters/ConfirmButton.set_deferred("disabled", false)
	else:
		$VBoxContainer/HBoxContainer/Characters/ConfirmButton.set_deferred("disabled", true)

func _on_CharacterButton4_pressed():
	selectOption(3)
	if $VBoxContainer/HBoxContainer/Characters/GridContainer/CharacterButton4.unlocked:
		$VBoxContainer/HBoxContainer/Characters/ConfirmButton.set_deferred("disabled", false)
	else:
		$VBoxContainer/HBoxContainer/Characters/ConfirmButton.set_deferred("disabled", true)

