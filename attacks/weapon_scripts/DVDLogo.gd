extends Node2D

var screen_width = get_viewport_rect().size.x
var screen_height = get_viewport_rect().size.y

var right_distance = 0
var left_distance = 0
var top_distance = 0
var bottom_distance = 0

var level = 0
var damage = 1
var speed = 1000
var dir = Vector2(0.1,0.1)

onready var hurtbox = $CollisionShape2D

func level_up():
	level += 1
	match level:
		1:
			position = Vector2.ZERO
			$CollisionShape2D.set_deferred("disabled", false)
			$Sprite.set_deferred("visible", true)


func _physics_process(delta):
	position += dir*speed*delta


func get_name():
	return "DVD Logo"
	
func get_icon():
	return "res://assets/weaponArt/DVD_logo.png"

func get_level():
	return level

func get_desc():
	return "Bounces around the screen, damaging enemies."


func _on_DVDLogo_body_entered(body):
	if body.has_method("hit_for"):
		body.hit_for(damage)


func _on_Top_viewport_exited(viewport):
	dir.y *= (-1)


func _on_Bottom_viewport_exited(viewport):
	dir.y *= (-1)


func _on_Left_viewport_exited(viewport):
	dir.x *= (-1)


func _on_Right_viewport_exited(viewport):
	dir.x *= (-1)
