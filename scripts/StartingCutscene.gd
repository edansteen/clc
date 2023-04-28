extends Node

var slideNum = 0
var ready = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if ready:
		if event is InputEventMouseButton or event is InputEventKey:
			next_slide()
			slideNum += 1
func next_slide():
	match(slideNum):
		0:
			var e = get_tree().change_scene("res://game/Main.tscn")
			if e != OK:
				print("Error! Couldn't load properly.")
