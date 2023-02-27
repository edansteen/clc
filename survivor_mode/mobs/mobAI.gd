extends KinematicBody2D

	#spawn
func _ready():
	position = get_node("Player").position + Vector2(1000,0).rotated(RandomNumberGenerator.new().rand_rng(0, 2*PI))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(get_node("Player").position - position)
	
	if position.x >= (get_viewport().x+1000) or position.x < -1000 or position.y >= (get_viewport().y+1000) or position.y < -100:
		queue_free()

func hit():
	queue_free()
	pass
