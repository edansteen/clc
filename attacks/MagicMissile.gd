# Flies straight toward the nearest enemy
extends Area2D

var level = 1
var hp = 1 #number of enemies to pierce through
var speed = 100
var damage = 5
var knock_amount = 100
var attack_size = 1.0
var cooldown = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

onready var player = get_tree().get_nodes_in_group("player")[0]

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + 135*PI/180 #135 degrees to rad
	match level:
		1:
			hp = 1
			speed = 100
			damage = 5
			knock_amount = 100
			attack_size = 1.0
			cooldown = 1.0

 
func _physics_process(delta):
	position += angle*speed*delta


func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()


func _on_Lifetime_timeout():
	queue_free()
