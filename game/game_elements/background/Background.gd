# Script for infinite background. Tiles can also have their textures changed
extends Node2D

const M = 3
const WIDTH = M*1980
const HEIGHT = M*1080

enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var options = [
	preload("res://assets/sprites/backgrounds/grass.png"), 
	preload("res://assets/sprites/backgrounds/xes.png"),
]

onready var tiles = $Tiles.get_children()

func set_bg(n):
	if n > options.size():
		return
	for t in $Tiles.get_children():
		t.set_texture(options[n])


func move(d):
	var walls = $Walls
	match (d):
		DIRECTION.UP:
			for t in tiles:
				if t.position.y > walls.position.y:
					t.position.y -= HEIGHT
			walls.position.y -= HEIGHT/M
		DIRECTION.DOWN:
			for t in tiles:
				if t.position.y < walls.position.y:
					t.position.y += HEIGHT
			walls.position.y += HEIGHT/M
		DIRECTION.LEFT:
			for t in tiles:
				if t.position.x > walls.position.x:
					t.position.x -= WIDTH
			walls.position.x -= WIDTH/M
		DIRECTION.RIGHT:
			for t in tiles:
				if t.position.x < walls.position.x:
					t.position.x += WIDTH
			walls.position.x += WIDTH/M


func _on_Left_body_entered(body):
	if body.has_method("hit"):
		move(DIRECTION.LEFT)


func _on_Right_body_entered(body):
	if body.has_method("hit"):
		move(DIRECTION.RIGHT)


func _on_Up_body_entered(body):
	if body.has_method("hit"):
		move(DIRECTION.UP)


func _on_Down_body_entered(body):
	if body.has_method("hit"):
		move(DIRECTION.DOWN)

