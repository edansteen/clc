extends Area2D

var damage = 50.0
var speed = 200.0
var dir = Vector2.ZERO

func set_dir(angle):
	dir = Vector2(cos(angle), sin(angle))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += dir*speed*delta

func _on_Lifetime_timeout():
	queue_free()

func _on_DaggerProjectile_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage)
		queue_free()
