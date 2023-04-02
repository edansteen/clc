extends KinematicBody2D

export var speed = 50.0
export var hp = 15

var velocity = Vector2()
var max_distance = 1500

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var sprite = $AnimatedSprite 
onready var animation_player = $AnimatedSprite/AnimationPlayer

var death_effect = preload("res://mobs/EnemyDeathEffect.tscn")
var explosion = preload("res://mobs/mob_projectiles/Explosion.tscn")
var xp = preload("res://items/ExpPoint.tscn")

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
		if collision.collider.has_method("hit"): #explode if it's the player
			hit_for(hp)


func hit_for(dmg):
	if hp >= 0: #avoids small bug where mob is hit while despawning
		hp -= dmg
		animation_player.play("hurt")
		$HitSoundEffect.play()
		if hp <= 0:
				sprite.play("death")
				$FuseSound.play()
				$Hitbox.set_deferred("disabled", true)


func explode():
	# add death effect
	call_deferred("add_child", death_effect.instance())
	var dropped_xp = xp.instance()
	dropped_xp.global_position = global_position
	get_parent().call_deferred("add_child", dropped_xp)
	var death_explosion = explosion.instance()
	death_explosion.global_position = global_position
	get_parent().call_deferred("add_child", death_explosion)


func _on_AnimatedSprite_animation_finished():
	if hp <= 0:
		explode()
		queue_free()
	else:
		sprite.play("move")
