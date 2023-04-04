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
var direction = Vector2.ZERO

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
	state = phase.IDLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if hp <= 0:
		return
	
	match(state):
		phase.IDLE:
			speed = 50
			target_position = player.global_position
		phase.PREP:
			speed = 0
		phase.CHARGE:
			speed = 500
			#check if near target point
				#if passed it, go into slow phase
			if global_position.distance_to(target_position) < 1:
				slow_down()
		phase.SLOW:
			#slow to a stop
			if speed > 0:
				speed -= 10
			elif speed < 0:
				speed = 0
	
	if state != phase.CHARGE:
		direction = global_position.direction_to(player.global_position)
	
	if direction.x >= 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

	if speed > 60:
		sprite.play("charge")
	else:
		sprite.play("idle")
	
	
	var collision = move_and_collide(direction.normalized() * speed * delta)
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


func charge():
	$Sounds/ChargingSound.play()
	target_position = player.global_position
	direction = global_position.direction_to(target_position)
	speed = 300

func slow_down():
	state = phase.SLOW
	$Sounds/Huff.play()
	$ChargingSound.stop()

func _on_AnimatedSprite_animation_finished():
	if hp <= 0:
		queue_free()
	else:
		sprite.play("idle")


func _on_ChargeCooldown_timeout():
	state = phase.PREP
	$Sounds/PrepCharge.play()

func _on_PrepCharge_finished():
	state = phase.CHARGE
	charge()
