#rotates around its origin point, gradually increasing its radius

extends Area2D

var enemies_in_range = []
var pull_strength = 100
var rotation_speed = 0.03 #in radians
var damage = 1
var speed = 100
var radius = 10
var duration = 6.0

var angle = 0
var dir = Vector2.ZERO
var origin_point = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = get_tree().get_nodes_in_group("player")[0].global_position
	var angle = rand_range(0,2*PI)
	dir = Vector2(cos(angle), sin(angle))

func set_level(n):
	match n:
		1:
			pass

func _physics_process(delta):
	position += dir*speed*delta
	
	for enemy in enemies_in_range:
		enemy.global_position = (enemy.global_position - global_position/(pull_strength))
		enemy.hit_for(damage)

func set_dir(d):
	dir = d

func _on_Area2D_body_entered(body):
	if body.has_method("hit_for"):
		if !enemies_in_range.has(body):
			enemies_in_range.append(body)


func _on_Area2D_body_exited(body):
	if enemies_in_range.has(body):
		enemies_in_range.erase(body)


func _on_Lifetime_timeout():
	queue_free()
