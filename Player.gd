extends KinematicBody2D

export var speed = 200
export var attack_dmg = 1000
export var hp = 100

var velocity := Vector2()
var game_over := false

var immunity_frames := 4

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = 0
	position.y = 0
	game_over = false
	$Camera2D.make_current()

func get_input():
	velocity = Vector2()
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func hit():
	if !game_over:
		game_over = true
		$AnimatedSprite.play("hit")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if game_over:
		$AnimatedSprite.rotate(0.1)
		return
		
	get_input()
	
	if velocity.x != 0 or velocity.y != 0:
		if velocity.x > 0:
			$AnimatedSprite.flip_h = false
		elif velocity.x < 0: 
			$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
	
	var collision = move_and_collide(velocity.normalized()*speed*delta)
	
	if collision:
		if collision.collider.has_method("hit_for"):
			collision.collider.hit_for(attack_dmg)


func _on_ImmunityCooldown_timeout():
	pass # Replace with function body.
