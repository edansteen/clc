extends KinematicBody2D

export (int) var gravity = 1600
export (int) var jumpSpeed = 600

var jumping = false 
var velocity = Vector2()
var double_jumped = false
var is_defeated = false

func _ready():
	is_defeated = false

func get_input():
	if Input.is_action_just_pressed("jump") and !double_jumped: #double jump
		jumping = true
		double_jumped = true
		velocity.y = 0-jumpSpeed
	#shoot
	if Input.is_action_just_pressed("click"):
		pass

func move_to(pos):
	position = pos

func defeat():
	is_defeated = true
	$AnimatedSprite.play("hit")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_defeated:
		return
	
	get_input()
	
	if is_on_floor():
		$AnimatedSprite.play("running")
	else:
		if velocity.y <= 0:
			$AnimatedSprite.play("jumping")
		else:
			$AnimatedSprite.play("falling")
			
	#reset double jump
	if jumping and is_on_floor():
		jumping = false
		double_jumped = false
		
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0,-1))
	
	

