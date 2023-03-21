extends Area2D

var xp_value = 20
var target = null
var speed = 0

func _process(_delta):
	pass

func grab_xp():
	return xp_value

func fly_to(t):
	target = t
