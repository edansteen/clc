extends KinematicBody2D

export var speed = 1

	#spawn
func _ready():
	position = get_node("Player").position + Vector2(1000,0).rotated(RandomNumberGenerator.new().rand_rng(0, 2*PI))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if position.x >= (get_viewport().x+1000) or position.x < -1000 or position.y >= (get_viewport().y+1000) or position.y < -100:
		queue_free()
		
	var collision = move_and_collide(get_node("SurvivorPlayer").position - position)

	if collision:
		print(collision.collider.name) 
		if collision.collider.has_method("hit"): #hit if it's the player
			collision.collider.hit()
		else:
			is_hit()
	else:
		$AnimatedSprite.play("move")
	
func is_hit():
	$AnimatedSprite.play("hit")
	queue_free()
	pass
