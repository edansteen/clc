# Briefly strikes a random point on the screen dealing damage
extends Area2D

var damage = 20.0
var area = 1.0
var duration = 0.2 #duration of animation in s

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Duration.start(duration)


func set_level(lvl):
	match lvl:
		1:
			damage = 20.0
			area = 1.0


func _on_Duration_timeout():
	queue_free()


func _on_Lightning_body_entered(body):
	if body.has_method("hit_for"):
		body.hit_for(damage)
