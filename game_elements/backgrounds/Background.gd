extends CanvasLayer

var tile = preload("res://game_elements/backgrounds/BackgroundComponent.tscn")
onready var player = get_tree().get_nodes_in_group("player")[0]
onready var main = player.get_parent()

const TILE_WIDTH = 1024
const TILE_HEIGHT = 640

var tiles = []
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var p_pos = player.global_position
	var main_tile = null
	
	#get the nearest tile to the player
	for t in tiles:
		if t.global_position.distance_to(p_pos) < t.position.distance_to(Vector2(t.position+TILE_WIDTH/2,t.position+TILE_HEIGHT/2)):
			main_tile = t
			break
	
	if main_tile == null:
		return
		
	#get position of player relative to nearest tile
	var player_moving_down = true
	var player_moving_right = true
	
	if p_pos.x >= main_tile.global_position.x:
		player_moving_right = true
	else:
		player_moving_right = false
	if p_pos.y >= main_tile.global_position.y:
		player_moving_down = true
	else:
		player_moving_down = false
		
	var mt_pos = main_tile.global_position
	#move other tiles accordingly
	for tile in tiles:
		if tile != main_tile:
			var tpos_y = tile.global_position.y
			var tpos_x = tile.global_position.x
			#move for the y
			if player_moving_down:
				if tpos_y < mt_pos.y:
					tpos_y += 2*TILE_HEIGHT
			else:
				if tpos_y > mt_pos.y:
					tpos_y -= 2*TILE_HEIGHT

			#move for the x
			if player_moving_right:
				if tpos_x < mt_pos.x:
					tpos_x += 2*TILE_WIDTH
			else:
				if tpos_x > mt_pos.x:
					tpos_x -= 2*TILE_WIDTH

