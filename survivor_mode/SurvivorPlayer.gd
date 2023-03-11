extends KinematicBody2D

export var speed = 400

var velocity = Vector2()
var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 0
	position.y = 0
	game_over = false
	$Camera2D.make_current()

func get_input():
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir * speed
	if Input.is_action_just_pressed("click"):
		pass

func hit():
	game_over = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if game_over:
		print("game_over")
		return
	velocity = Vector2()
	
	get_input()
	
	if velocity.x != 0 or velocity.y != 0:
		if velocity.x > 0:
			$AnimatedSprite.flip_h = false
		elif velocity.x < 0: 
			$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
	
	var collision = move_and_collide(velocity.normalized() * delta)
	
	if collision:
		pass
