extends Area2D

var damage = 8.0

func set_level(lvl, dmg_multiplier):
	match lvl:
		1:
			damage = 8.0
		2:
			damage = 10.0
		3:
			damage = 14.0
		4:
			damage = 18.0
		5:
			damage = 22.0
		6:
			damage = 30.0
	damage *= dmg_multiplier

func _on_OrbProjectile_body_entered(body):
	if body.has_method("hit_for"):
		body.hit_for(damage)
