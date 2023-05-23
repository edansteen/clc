extends Area2D


var damage = 12.0
var speed = 500.0
var area = 1.0
var knockback = 30.0
var piercing = 1 #number of enemies projectile pierces before disappearing

var dir = Vector2.ZERO

	
func set_level(lvl) -> void:
	match lvl:
		1:
			damage = 12.0
			speed = 300.0
			area = 1.0
			knockback = 30.0
			piercing = 1
	damage *= Globals.damageMultiplier


func set_dir(angle):
	dir = Vector2(cos(angle), sin(angle))
	$Sprite.rotation = dir.angle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += dir*speed*delta


func _on_Lifetime_timeout():
	queue_free()


func _on_DaggerProjectile_body_entered(body):
	if body.has_method("hit_for"):
		body.hit_for(damage)
		piercing -= 1
		if piercing <= 0:
			queue_free()
