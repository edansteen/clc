extends KinematicBody2D

export var gravity = 2000
export var speed = 2
var velocity = Vector2()
var stop = false
var hit = false

# Called when the node enters the scene tree for the first time.
func _ready():
	stop = false
	hit = false

func spawn(pos):
	position = pos

func attack():
	pass
	
func is_hit():
	hit = true
	#$Hitbox.disable()
	#$AttackRange.disable()

func freeze():
	stop = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if position.x < -10:
		print("freed droid")
		queue_free()
	if hit:
		$AnimatedSprite.play("hit")
		
	if !stop:
		$AnimatedSprite.play("run")
		velocity.x -= speed * delta
	else:
		$AnimatedSprite.stop()
	
	var collision = move_and_collide(velocity)
	
	if collision:
		is_hit()
		print(collision.collider.name)
		#bpunce off
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
