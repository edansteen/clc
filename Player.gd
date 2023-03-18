extends KinematicBody2D

export var speed = 200.0
export var attack_dmg = 1
export var hp = 100
export var invincible = false

var velocity := Vector2()
var game_over := false

var immunity_time := 0.1

#Enemy Related
var enemy_close = []

# Nodes
onready var sprite = $AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 0
	position.y = 0
	game_over = false
	$Camera2D.make_current()

#Get keyboard input for movement
func get_input():
	velocity = Vector2()
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

#when hit
func hit():
	if !game_over:
		game_over = true
		sprite.play("hit")
	#else: #if hit, make sure player gets brief invincibility
	#	invincible = true
	#	$ImmunityTimer.start(immunity_time)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if game_over:
		sprite.rotate(0.1)
		return
		
	get_input()
	
	if velocity.x != 0 or velocity.y != 0:
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0: 
			sprite.flip_h = true
		sprite.play("run")
	else:
		sprite.play("idle")
	
	var collision = move_and_collide(velocity.normalized()*speed*delta)
	#grab items that can be picked up
	if collision:
		if collision.collider.has_method("grab"):
			collision.collider.grab()

func _on_ImmunityTimer_timeout():
	invincible = false

			
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.RIGHT

func _on_EnemyDetectionArea_body_entered(body):
	if !enemy_close.has(body):
		enemy_close.append(body)

func _on_EnemyDetectionArea_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
