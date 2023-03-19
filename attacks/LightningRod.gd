extends Node2D

var damage = 20.0
var area = 1.0
var projectile_num = 1
var duration = 0.5 #duration of animation in s
var level = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	match level:
		1:
			damage = 20.0
			area = 1.0
			projectile_num = 1


func set_damage(d):
	damage = d


func _on_CooldownTimer_timeout():
	pass # Replace with function body.
