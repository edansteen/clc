extends KinematicBody2D

export var gravity = 2000
export var speed = 1
var velocity = Vector2()
var stop = false

# Called when the node enters the scene tree for the first time.
func _ready():
	stop = false

func spawn(pos):
	position = pos

func attack():
	pass
	
func is_hit():
	$CollisionShape2D.disable()
	$AttackRange.disable()
	$AnimatedSprite.play("hit")

func freeze():
	stop = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if position.x < -10:
		print("freed droid")
		queue_free()
	if !stop:
		$AnimatedSprite.play("run")
		velocity.x -= speed
		velocity.y += gravity * delta
	else:
		$AnimatedSprite.stop()
	velocity = move_and_slide(velocity, Vector2(0,-1))
