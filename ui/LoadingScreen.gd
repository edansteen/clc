#The loading screen waits to make sure the game saves before moving on
extends Control

var path = null

onready var icon = $CanvasLayer/HBoxContainer/LoadingIcon
var ready : bool = false

func _input(event):
	if ready:
		if event is InputEventMouseButton or event is InputEventKey:
			if path == null:
				var e = get_tree().change_scene("res://TitleScreen.tscn")
				if e != OK:
					print("Error!")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	icon.rotate(0.02)

func set_path(p):
	path = p

func _on_LoadTime_timeout():
	ready = true
	$CanvasLayer/Continue.set_deferred("visible",true)
