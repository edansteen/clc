extends Control

var slideNum = 0
var ready = false

onready var slides = $Slides.get_children()

func _input(event):
	if ready:
		if event is InputEventMouseButton or event is InputEventKey:
			$Slides/Continue.set_deferred("visible", false)
			next_slide()

func next_slide():
	match(slideNum):
		0:
			var e = get_tree().change_scene("res://game/Main.tscn")
			if e != OK:
				print("Error! Couldn't load properly.")
	slideNum += 1
	$ShowContinue.start(4.0)

func _on_ShowContinue_timeout():
	ready = true
	$CanvasLayer/Continue.set_deferred("visible", true)
