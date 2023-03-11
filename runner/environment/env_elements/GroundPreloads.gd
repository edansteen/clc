extends Node2D

var active_preload = 0
var children = []
# Called when the node enters the scene tree for the first time.
func _ready():
	active_preload = 0
	var i = 0
	for node in get_children():
		children[i] = node

func switch_ground():
	pass
	
func clear():
	for node in get_children():
		node.set_layer_enabled(false)
