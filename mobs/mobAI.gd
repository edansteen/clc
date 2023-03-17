extends KinematicBody2D

export var speed = 50.0
export var hp = 100

var velocity = Vector2()

var max_distance = 1200

onready var player = get_tree().get_nodes_in_group("player")[0]
 
var death_effect = preload("res://mobs/EnemyDeathEffect.tscn")

func _ready():
	var rng = RandomNumberGenerator.new()
	position.x = player.global_position.x + rng.randi_range(1000-max_distance, max_distance-1000)
	position.y = player.global_position.y + rng.randi_range(1000-max_distance, max_distance-1000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var p_pos = player.global_position
	if global_position.x >= (p_pos.x+max_distance) or global_position.x < 0-max_distance or global_position.y >= (p_pos.y+1000) or position.y < -100:
		queue_free()
		
	var direction = global_position.direction_to(p_pos)
	velocity = direction.normalized() * speed

	if velocity.x != 0 or velocity.y != 0:
		if velocity.x > 0:
			$AnimatedSprite.flip_h = false
		elif velocity.x < 0: 
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("move")
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		if collision.collider.has_method("hit"): #hit if it's the player
			collision.collider.hit()
	
func hit_for(dmg):
	hp -= dmg
	if hp <= 0:
			$AnimatedSprite.play("death")
			var de = death_effect.instance()
			de.position = position
			get_parent().call_deferred("add_child", de)
			queue_free()
	else:
		$AnimatedSprite.play("hit")
		
