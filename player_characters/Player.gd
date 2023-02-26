extends KinematicBody2D

export (int) var gravity = 1600
export (int) var jumpSpeed = 600
export (int) var b_mode_timer_max = 10 #in s
export (int) var starting_x = 250
export (int) var starting_y = 280

var velocity = Vector2()
var double_jumped = false
var is_hit = false
var buff_mode = false
var buff_mode_timer = 0

#chonk mode disables the double jump limit (holding space makes you float up, releasing let's you fall
#var chonk_mode = false
#var chonk_mode_timer = 0
#var c_mode_timer_max = 10 #in s

func _ready():
	buff_mode = false
	buff_mode_timer = 0
	is_hit = false


func get_input():
	if Input.is_action_just_pressed("ui_up"): 
		if buff_mode:
			gravity = 2000
			if is_on_floor():
				velocity.y = 0-jumpSpeed*1.8
		else:
			gravity = 1600
			if !double_jumped: #double jump
				double_jumped = true
				velocity.y = 0-jumpSpeed
		
	if Input.is_action_just_pressed("ui_down"):
		velocity.y += jumpSpeed/2


func spawn():
	position.x = starting_x
	position.y = starting_y


func buff_transform():
	buff_mode = true
	buff_mode_timer = 0
	$Hitbox.disabled = true
	$BuffHitbox.disabled = false
	position.y = 200
	

func hit():
	is_hit = true
	$AnimatedSprite.play("hit")


#return true if buff_mode, else false
func is_buff():
	if buff_mode:
		return true
	return false


#func is_chonk():
#	if chonk_mode:
#		return true
#	return false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_hit:
		return
	
	get_input()
	
	#make sure not moving horizontally due to collision bugs
	position.x = starting_x
	
	if buff_mode: 
		$AnimatedSprite.play("buff")
		buff_mode_timer += delta
		if buff_mode_timer >= b_mode_timer_max:
			buff_mode = false
			$BuffHitbox.disabled = true
			$Hitbox.disabled = false
	else:
		if is_on_floor():
			$AnimatedSprite.play("running")
		else:
			if velocity.y <= 0:
				$AnimatedSprite.play("jumping")
			else:
				$AnimatedSprite.play("falling")
	
	#reset double jump
	if is_on_floor():
		double_jumped = false
		
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2(0,-1))
