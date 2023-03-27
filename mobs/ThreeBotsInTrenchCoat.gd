extends KinematicBody2D

export var speed = 50.0
export var hp = 40
export var damage = 15

var velocity = Vector2()
var max_distance = 1500

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var sprite = $AnimatedSprite 
onready var animation_player = $AnimatedSprite/AnimationPlayer

var microbots = preload("res://mobs/Microbot.tscn")

func _ready():
	sprite.play("move")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if hp <= 0:
		return
	var p_pos = player.global_position
	
	#despawn if too far from player
	
	var direction = global_position.direction_to(p_pos)
	velocity = direction.normalized() * speed

	if velocity.x != 0 or velocity.y != 0:
		if velocity.x > 0:
			sprite.flip_h = false
		elif velocity.x < 0: 
			sprite.flip_h = true
			sprite.play("move")
			
	var collision = move_and_collide(velocity * delta)	
	if collision:
		if collision.collider.has_method("hit"): #hit if it's the player
			collision.collider.hit(damage)


func hit_for(dmg):
	if hp >= 0: #avoids small bug where mob is hit while despawning
		hp -= dmg
		animation_player.play("hurt")
		$HitSoundEffect.play()
		if hp <= 0:
				sprite.play("death")
				$Hitbox.queue_free()
				# add death effect
				for i in range(3):
					var bots = microbots.instance()
					bots.position.x = position.x
					bots.position.y = position.y - 20 + (20*i)
					get_parent().call_deferred("add_child", bots)


func _on_AnimatedSprite_animation_finished():
	if hp <= 0:
		queue_free()
	else:
		sprite.play("move")
