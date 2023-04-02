#Periodically charges at player, dealing high damage
#idle phase #cooldown after charging
#prep phase #preparing to charge
#charge phase #run fast at player's last position
#slow down phase #slow down to a stop after reaching player's last position

extends KinematicBody2D

var speed = 100.0
var hp = 2000
var damage = 50
var velocity = Vector2()
var target_position = Vector2.ZERO #the position bull charges towards

var charge_coooldown = 6.0
enum phase {IDLE,PREP,CHARGE,SLOW}
var state = phase.IDLE

var death_effect = preload("res://mobs/mob_projectiles/ExplosionDeathEffect.tscn")

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var sprite = $AnimatedSprite 
onready var animation_player = $AnimatedSprite/AnimationPlayer
onready var charge_timer = $ChargeCooldown

func _ready():
	sprite.play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if hp <= 0:
		return
	var p_pos = player.global_position
	
	var direction = global_position.direction_to(p_pos)
	velocity = direction.normalized() * speed

	if velocity.x != 0 or velocity.y != 0:
		if velocity.x > 0:
			sprite.flip_h = true
		elif velocity.x < 0: 
			sprite.flip_h = false
		sprite.play("charge")
	else:
		sprite.play("idle")
		
	var collision = move_and_collide(velocity * delta)	
	if collision:
		if collision.collider.has_method("hit"): #hit if it's the player
			collision.collider.hit(damage)
			
		elif collision.collider.has_method("hit_for"): #also hit mobs if charging
			if state == phase.CHARGE or state == phase.SLOW: 
				collision.collider.hit_for(damage)


func hit_for(dmg):
	if hp >= 0: 
		hp -= dmg
		animation_player.play("hurt")
		$HitSoundEffect.play()
		if hp <= 0:
				sprite.play("death")
				$Hitbox.set_deferred("disabled", true)
				# add death effect
				call_deferred("add_child", death_effect.instance())

func charge_at(pos):
	pass

func _on_AnimatedSprite_animation_finished():
	if hp <= 0:
		queue_free()
	else:
		sprite.play("idle")


func _on_ChargeCooldown_timeout():
	charge_at(target_position)
