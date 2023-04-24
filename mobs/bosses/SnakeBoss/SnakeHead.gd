extends KinematicBody2D

signal defeated

var hp = 5000
var damage = 60
var speed = 60
var length = 10
var velocity = Vector2.ZERO
var tail = []
var body = preload("res://mobs/bosses/SnakeBoss/SnakeBody.tscn")

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var animation_player = $AnimationPlayer
onready var death_effect = preload("res://mobs/mob_projectiles/ExplosionDeathEffect.tscn")
onready var sprite = $AnimatedSprite

func _ready():
	for i in range(length):
		tail.append(body.instance())
		

func _physics_process(delta):
	$AnimatedSprite.rotation = get_angle_to(player.global_position)
	if hp <= 0:
		return
	var p_pos = player.global_position
	
	var direction = global_position.direction_to(p_pos)
	velocity = direction.normalized() * speed

	if velocity.x != 0 or velocity.y != 0:
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0: 
			sprite.flip_h = true
			
	var collision = move_and_collide(velocity * delta)	
	if collision:
		if collision.collider.has_method("hit"): #hit if it's the player
			collision.collider.hit(damage)
			
	for i in tail

func hit_for(dmg):
	if hp >= 0: 
		hp -= dmg
		animation_player.play("hurt")
		$HitSoundEffect.play()
		if hp <= 0:
			$Hitbox.set_deferred("disabled", true)
			# add death effect
			call_deferred("add_child", death_effect.instance())

