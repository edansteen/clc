extends Node2D

var damage = 0
var target = Vector2.ZERO
var angle = 0

func shoot(n, lvl): #n is number of instances after this one, lvl is level
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var mobs = get_tree().get_nodes_in_group("mobs")
	if mobs.size() == 0:
		return null
	var nearest_mob = mobs[0]
	for mob in mobs:
		if mob.global_position.distance_to(global_position) < nearest_mob.global_position.distance_to(global_position):
			nearest_mob = mob
	target = nearest_mob
	target.hit_for()
	look_at(target.global_position)
	angle = (target.global_position - global_position).normalized()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
