extends KinematicBody2D

var move_up = true
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	move_up = true
	position.x = 512
	position.y = 450

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x <= -20:
		queue_free()
	
	if position.y >= 450:
		move_up = true
	elif position.y <= 350:
		move_up = false
		
	if move_up:
		velocity.y = 0-1
	else:
		velocity.y = 1

	velocity.x = 0-1
	
	var collision = move_and_collide(velocity)
	if collision and collision.collider.has_method("transform"):
			collision.collider.transform()
			queue_free()
	
