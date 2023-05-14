extends KinematicBody2D

export var speed = 50.0
export var hp = 500
export var damage = 20
export var shoot_cooldown = 6.0

var velocity = Vector2()
var max_distance = 1500

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var main = player.get_parent()

onready var sprite = $AnimatedSprite 
onready var animation_player = $AnimatedSprite/AnimationPlayer

onready var muzzles = [$Muzzle1, $Muzzle2]

var death_effect = preload("res://game/game_elements/mobs/mob_projectiles/ExplosionDeathEffect.tscn")
var xp = preload("res://game/game_elements/items/ExpPoint.tscn")

var bullet = preload("res://game/game_elements/mobs/mob_projectiles/MobBullet.tscn")

func _ready():
	sprite.play("move")
	$ShootCooldown.start(shoot_cooldown)

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
	if hp >= 0: 
		hp -= dmg
		animation_player.play("hurt")
		$HitSoundEffect.play()
		if hp < 200:
			shoot_cooldown = 4.0
			if hp <= 0:
				sprite.play("death")
				$Hitbox.set_deferred("disabled", true)
				# add death effect
				call_deferred("add_child", death_effect.instance())
				var dropped_xp = xp.instance()
				dropped_xp.global_position = global_position
				get_parent().call_deferred("add_child", dropped_xp)


func _on_AnimatedSprite_animation_finished():
	if hp <= 0:
		queue_free()
	else:
		sprite.play("move")


func _on_ShootCooldown_timeout():
	for muzzle in muzzles:
		var b = bullet.instance()
		main.call_deferred("add_child", b)
		b.global_position = muzzle.global_position
		b.set_dir(muzzle.get_angle_to(player.global_position))
	$ShootCooldown.start(shoot_cooldown)
	
