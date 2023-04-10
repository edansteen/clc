extends Area2D

var damage = 0

func set_level(lvl):
	match lvl:
		1:
			damage = 12

func _on_Slash_body_entered(body):
	if body.has_method("hit_for"):
		body.hit_for(damage)


func _on_Duration_timeout():
	queue_free()
