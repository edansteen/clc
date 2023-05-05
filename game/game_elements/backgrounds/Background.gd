# Script for infinite background. Tiles can also have their textures changed
extends Node2D

const WIDTH = 2*1980
const HEIGHT = 2*1080

enum DIRECTION {LEFT, RIGHT, UP, DOWN}

var options = ["res://assets/sprites/grass_tile.png"]

onready var tiles = $Tiles.get_children()

func set_tile_pattern(n):
	for t in $Tiles.get_children():
		t.set_texture(options[n])


func move(d):
	var walls = $Walls
	match (d):
		DIRECTION.UP:
			walls.position.y -= HEIGHT/2
			for t in tiles:
				if t.position.y > walls.position.y:
					t.position.y -= HEIGHT
		DIRECTION.DOWN:
			walls.position.y += HEIGHT/2
			for t in tiles:
				if t.position.y < walls.position.y:
					t.position.y += HEIGHT
		DIRECTION.LEFT:
			walls.position.x -= WIDTH/2
			for t in tiles:
				if t.position.x < walls.position.x:
					t.position.x -= WIDTH
		DIRECTION.RIGHT:
			walls.position.x += WIDTH/2
			for t in tiles:
				if t.position.x > walls.position.x:
					t.position.x += WIDTH


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

