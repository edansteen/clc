# Briefly strikes a random point on the screen dealing damage
extends Area2D

var damage = 20.0
var area = 1.0
var projectile_num = 1
var duration = 0.5 #duration of animation in s
var level = 1

var margin_x = 20
var margin_y = 10

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	match level:
		1:
			damage = 20.0
			area = 1.0
			projectile_num = 1
	#place in random position on the screen
	var vpr = get_viewport_rect().size
	global_position.x = rng.randf_range(margin_x,vpr.x-margin_x)
	global_position.y = rng.randf_range(margin_y,vpr.y-margin_y)
	$Duration.start(duration)


func set_damage(d):
	damage = d


func _on_Duration_timeout():
	queue_free()


func _on_Lightning_body_entered(body):
	if body.has_method("hit_for"):
		body.hit_for(damage)
