#Periodically charges at player, dealing high damage
#idle phase #cooldown after charging
#prep phase #preparing to charge
#charge phase #run fast at player's last position
#slow down phase #slow down to a stop after reaching player's last position

extends KinematicBody2D

var move_speed = 100.0 + (10*Globals.selectedLevel)
var charge_speed = 400.0 + (30*Globals.selectedCharacter)
var speed = move_speed
var hp_max = 2000 + (2000*Globals.selectedLevel)
var hp = hp_max
var damage = 50 * (100*Globals.selectedLevel)
var velocity = Vector2()
var target_position = Vector2.ZERO #the position bull charges towards
var direction = Vector2.ZERO

var charge_coooldown = 6.0
enum phase {IDLE,PREP,CHARGE,SLOW}
var state = phase.IDLE


var death_effect = preload("res://game/game_elements/mobs/mob_projectiles/ExplosionDeathEffect.tscn")

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var sprite = $Sprite
onready var warning = $VisualWarning 
onready var animation_player = $Sprite/AnimationPlayer
onready var charge_timer = $ChargeCooldown

func _ready():
	sprite.play("move")
	state = phase.IDLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if hp <= 0:
		return
		
	match(state):
		phase.IDLE:
			target_position = player.global_position
			direction = global_position.direction_to(target_position)
		phase.CHARGE:
			#check if near target point
				#if passed it, go into slow phase
			if global_position.distance_to(target_position) < 5:
				state = phase.SLOW
		phase.SLOW:
			#slow to a stop
			speed -= 10
			if speed <= 0:
				state = phase.IDLE
				speed = move_speed
				sprite.speed_scale = 1
				warning.set_deferred("visible", false)
				$Sounds/Huff.play()
				$Sounds/ChargingSound.stop()
				charge_timer.start(charge_coooldown)

	if direction.x >= 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	var collision = move_and_collide(direction.normalized() * speed * delta)
	if collision:
		if collision.collider.has_method("hit"): #hit if it's the player
			collision.collider.hit(damage)
			$Sounds/ChargingSound.stop()
			$Sounds/Huff.play()
			
		elif collision.collider.has_method("hit_for"): #also hit mobs if charging
			if state == phase.CHARGE or state == phase.SLOW: 
				collision.collider.hit_for(2000)

func hit_for(dmg):
	if hp >= 0: 
		hp -= dmg
		animation_player.play("hurt")
		$Sounds/HitSoundEffect.play()
		if hp <= 0:
				#add death effect
				$Sounds/DeathSound.play()
				$Hitbox.set_deferred("disabled", true)
				# add death effect
				$DeathAnimation.set_deferred("visible",true)
				$DeathAnimation.play("explode")
				call_deferred("add_child", death_effect.instance())
				get_tree().get_nodes_in_group("player")[0].get_parent().boss_defeated()
		elif state == phase.IDLE:
			if hp <= hp_max/2:
				if hp <= hp_max/6:
					charge_coooldown = 1.0
				charge_speed = 450.0
				charge_coooldown = 4.0

func prep_charge():
	speed = 0
	state = phase.PREP
	$Sounds/PrepCharge.play()
	warning.set_deferred("visible", true)


func _on_AnimatedSprite_animation_finished():
	sprite.play("move")


func _on_ChargeCooldown_timeout():
	prep_charge()

func _on_PrepCharge_finished():
	state = phase.CHARGE
	speed = charge_speed
	sprite.speed_scale = 2
	$Sounds/ChargingSound.play()
	target_position = player.global_position
	direction = global_position.direction_to(target_position)

#charge if off screen
func _on_VisibilityNotifier2D_screen_exited():
	prep_charge()


func _on_DeathAnimation_animation_finished():
	queue_free()
