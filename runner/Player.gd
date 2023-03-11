extends KinematicBody2D

export (int) var gravity = 1600
export (int) var jumpSpeed = 600
export (int) var b_mode_timer_max = 10 #timer for buff mode in s
export (int) var starting_x = 250
export (int) var starting_y = 280
export (int) var r_mode_timer_max = 10 #timer for round mode in s

var velocity = Vector2()
var double_jumped = false
var is_hit = false
var buff_mode = false
var mode_timer = 0
var round_mode = false


func _ready():
	buff_mode = false
	round_mode = false
	mode_timer = 0
	is_hit = false
	gravity = 1600


func get_input():
	if round_mode:
		if Input.is_action_pressed("ui_up"):
			velocity.y = (0-jumpSpeed)/1.5
			
		return
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
	round_mode = false
	mode_timer = 0
	$Hitbox.disabled = true
	$RoundHitbox.disabled = true
	$BuffHitbox.disabled = false
	
	
func round_transform():
	round_mode = true
	buff_mode = false
	mode_timer = 0
	$Hitbox.disabled = true
	$BuffHitbox.disabled = true
	$RoundHitbox.disabled = false


func hit():
	is_hit = true
	$AnimatedSprite.play("hit")


#return true if buff_mode, else false
func is_buff():
	if buff_mode:
		return true
	return false

func is_round():
	if round_mode:
		return true
	else:
		return false

func is_hit():
	return is_hit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_hit:
		return
	
	get_input()
	
	#make sure not moving horizontally due to collision bugs
	position.x = starting_x
	
	if buff_mode: 
		$AnimatedSprite.play("buff")
		mode_timer += delta
		if mode_timer >= b_mode_timer_max:
			buff_mode = false
			$BuffHitbox.disabled = true
			$Hitbox.disabled = false
	elif round_mode:
		$AnimatedSprite.play("round")
		mode_timer += delta
		if mode_timer >= r_mode_timer_max:
			round_mode = false
			$RoundHitbox.disabled = true
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
	
	if position.y > 600:
		hit()
