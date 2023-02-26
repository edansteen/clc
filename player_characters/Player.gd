extends KinematicBody2D

export (int) var gravity = 1600
export (int) var jumpSpeed = 600
export var b_mode_timer_max = 10 #in s

var jumping = false 
var velocity = Vector2()
var double_jumped = false
var is_defeated = false
var buff_mode = false
var buff_mode_timer = 0

func _ready():
	buff_mode = false
	buff_mode_timer = 0
	is_defeated = false


func get_input():
	if Input.is_action_just_pressed("ui_up") and !double_jumped: #double jump
		jumping = true
		double_jumped = true
		velocity.y = 0-jumpSpeed
	if Input.is_action_just_pressed("ui_down"):
		velocity.y += jumpSpeed/2


func move_to(pos):
	position = pos


func transform():
	buff_mode = true


func defeat():
	is_defeated = true
	$AnimatedSprite.play("hit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_defeated:
		return
	
	if !buff_mode: 
		get_input()
		
		if is_on_floor():
			$AnimatedSprite.play("running")
		else:
			if velocity.y <= 0:
				$AnimatedSprite.play("jumping")
			else:
				$AnimatedSprite.play("falling")
	else:
		$AnimatedSprite.play("buff")
		buff_mode_timer += delta
		if buff_mode_timer >= b_mode_timer_max:
			buff_mode = false
			
	#reset double jump
	if jumping and is_on_floor():
		jumping = false
		double_jumped = false
		
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0,-1))
