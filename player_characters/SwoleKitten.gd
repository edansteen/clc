extends KinematicBody2D

export (int) var gravity = 1600
export (int) var jumpSpeed = 600

var velocity = Vector2()
var is_defeated = false

func _ready():
	is_defeated = false

func get_input():
	if Input.is_action_just_pressed("jump"):
		velocity.y = 0-jumpSpeed

func move_to(pos):
	position = pos

func transform(): #transform back into normal kitten
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_defeated:
		return
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0,-1))
	
	

