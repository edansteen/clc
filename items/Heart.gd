extends Area2D

var target = global_position

func grab_heart():
	return 1

func fly_to(t):
	target = t
