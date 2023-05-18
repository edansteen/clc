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

func selectOption(n):
	match (n):
		0: #Cat
			pass
		1: #Wizard
			pass
		2: # RamboCat
			pass
		3: #Turtle
			pass
		4: #???
			pass
