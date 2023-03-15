extends KinematicBody2D

export var speed = 1
var player_pos = 1000
var velocity = Vector2()

var rng = RandomNumberGenerator.new()


func get_player_pos(pos):
	player_pos = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if position.x >= (get_viewport().size.x+1100) or position.x < -1100 or position.y >= (get_viewport().size.y+1000) or position.y < -100:
		queue_free()
		
	velocity = Vector2()
	
	var collision = move_and_collide(velocity)
	#$AnimatedSprite.play("move")
	
	if collision:
		print(collision.collider.name) 
		if collision.collider.has_method("hit"): #hit if it's the player
			collision.collider.hit()
		elif !collision.collider.has_method("is_hit"): #prevent mobs from hurting eachother
			is_hit()

	
func is_hit():
	$AnimatedSprite.play("hit")
	queue_free()
	pass
