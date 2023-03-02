extends Node

#https://www.youtube.com/watch?v=LgvLbahJOTA 
#https://www.youtube.com/watch?v=Z2TaFnN7cdU

var mob = preload("res://survivor_mode/mobs/Mob.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = $SurvivorPlayer.position
	
	for m in $Mobs.get_children():
		if m.has_method("get_player_pos"):
			m.get_player_pos(pos)
			
	if get_child_count() < 1000:
		#spawn mobs
		spawn_mob()

func spawn_mob():
	var m = mob.instance()
	m.position = $SurvivorPlayer.position + Vector2(2000,0).rotated(rng.randi_range(0, 2*PI))
	$Mobs.call_deferred("add_child", m)
	
