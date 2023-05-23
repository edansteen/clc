extends Area2D

var damage = 15.0
var speed = 250.0
var level = 0

var target = Vector2.ZERO
var angle = Vector2.RIGHT
var targets_list = [] 

func _ready():
	var mobs = get_tree().get_nodes_in_group("mobs")
	if mobs.size() == 0:
		return null
	target = mobs[randi() % mobs.size()]
	look_at(target.global_position)
	angle = (target.global_position - global_position).normalized()


func set_level(lvl) -> void:
	level = lvl
	match lvl:
		1:
			damage = 15.0
			speed = 300.0
		2:
			damage = 20
		3:
			damage = 30
		4:
			damage = 45
		5:
			damage = 60
		6:
			damage = 60
	damage *= Globals.damageMultiplier


func _process(delta):
	global_position += angle*speed*delta


func _on_LifeTimer_timeout():
	queue_free()


func _on_FireballProjectile_body_entered(body):
	if body.has_method("hit_for"):
		body.hit_for(damage)
