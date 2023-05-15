#projectile that automatically heads toward the nearest enemy
extends Area2D

var damage = 10.0
var speed = 300.0
var area = 1.0
var knockback = 30.0
var piercing = 1 #number of enemies projectile pierces before disappearing
var level = 0

var target = Vector2.ZERO
var angle = Vector2.RIGHT
var targets_list = [] #list of targets for lvl 6

func _ready():
	var mobs = get_tree().get_nodes_in_group("mobs")
	if mobs.size() == 0:
		return null
	var nearest_mob = mobs[0]
	for mob in mobs:
		if mob.global_position.distance_to(global_position) < nearest_mob.global_position.distance_to(global_position):
			nearest_mob = mob
	target = nearest_mob
	look_at(target.global_position)
	angle = (target.global_position - global_position).normalized()

func set_level(lvl) -> void:
	level = lvl
	match lvl:
		1:
			damage = 10.0
			speed = 300.0
			area = 1.0
			knockback = 30.0
			piercing = 1
		2:
			damage *= 1.5
			piercing = 1
		3:
			damage *= 1.5
			piercing = 2
		4:
			damage *= 1.5
			piercing = 2
		5:
			damage *= 1.5
			piercing = 3
		6:
			damage *= 1.5
			piercing = 4
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += angle*speed*delta


func _on_LifetimeTimer_timeout():
	queue_free()


func _on_MagicProjectile_body_entered(body):
	if body.has_method("hit_for"):
		body.hit_for(damage)
		piercing -= 1
		if piercing <= 0:
			$AnimatedSprite.connect("animation_finished", self, "_on_AnimatedSprite_animation_finished")
			$AnimatedSprite.play("impact")
			$CollisionShape2D.set_deferred("disabled", true)
			speed = 0
		if level >= 6:
			targets_list.append(target)
			var mobs = get_tree().get_nodes_in_group("mobs")
			if mobs.size() == 0:
				return null
			var nearest_mob = mobs[mobs.size()-1]
			for mob in mobs:
				if (not mob in targets_list) and (mob.global_position.distance_to(global_position) < nearest_mob.global_position.distance_to(global_position)):
					nearest_mob = mob
			target = nearest_mob
			look_at(target.global_position)
			angle = (target.global_position - global_position).normalized()


func _on_AnimatedSprite_animation_finished():
	queue_free()
