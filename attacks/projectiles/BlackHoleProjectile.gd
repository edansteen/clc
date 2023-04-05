extends Area2D

var enemies_in_range = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Lifetime_timeout():
	queue_free()


func _on_Area2D_body_entered(body):
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	pass # Replace with function body.
