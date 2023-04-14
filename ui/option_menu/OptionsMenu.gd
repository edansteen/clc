extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_volume(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)


func _on_VolumeLevel_value_changed(value):
	set_volume(value)
