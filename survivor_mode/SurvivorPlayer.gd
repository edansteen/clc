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
	if Input.is_action_pressed("up"):
		velocity.y = 0-1
	if Input.is_action_pressed("down"):
		velocity.y = 1
	if Input.is_action_pressed("left"):
		velocity.x = 0-1
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("right"):
		velocity.x = 1
		$AnimatedSprite.flip_h = false
	if Input.is_action_just_pressed("click"):
		pass

func hit():
	game_over = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2()
	
	if game_over:
		print("game_over")
		return
	get_input()
	
	if velocity.x != 0 or velocity.y != 0:
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
