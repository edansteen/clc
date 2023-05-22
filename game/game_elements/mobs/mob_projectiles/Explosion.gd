extends Area2D

var damage = 40 + (50*Globals.selectedLevel)

func _ready():
	$AnimatedSprite.play("default")
	$ExplodeSound.play()

func _on_Explosion_body_entered(body):
	if body.has_method("hit_for"):
		body.hit_for(damage)
	elif body.has_method("hit"):
		body.hit(damage)


func _on_AnimatedSprite_animation_finished():
	queue_free()


func _on_Duration_timeout():
	$CollisionShape2D.disabled = true
