extends KinematicBody2D

export (int) var gravity = 1200
export (int) var jumpSpeed = 400

var jumping = false 
var velocity = Vector2()


func _ready():
	pass # Replace with function body.

func get_input():
	if Input.is_action_just_pressed("jump"): 
		jumping = true
		velocity.y = jumpSpeed * (-1)

func move_to(pos):
	position = pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	
	velocity.y += gravity * delta
	
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0,-1))
