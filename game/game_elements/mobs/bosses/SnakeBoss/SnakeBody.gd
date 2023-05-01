extends Area2D

var damage = 30
var hp = 500

onready var animation_player = $Sprite/AnimationPlayer
var death_effect = preload("res://game/game_elements/mobs/mob_projectiles/ExplosionDeathEffect.tscn")

func _on_SnakeBody_body_entered(body):
	if body.has_method("hit"):
		body.hit(damage)

func hit_for(dmg):
	if hp >= 0: 
		hp -= dmg/2
		animation_player.play("hurt")
		$HitSoundEffect.play()
		if hp <= 0:
			$Hitbox.set_deferred("disabled", true)
			# add death effect
			call_deferred("add_child", death_effect.instance())
