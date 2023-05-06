extends Control

var data = {}

var save_path = preload("res://scripts/SaveScript.gd")
var SaveObject = null

#load data
func _ready():
	SaveObject = save_path.new()
	data = SaveObject.load_data()

func set_volume(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), (-50 + volume*100/7))


func _on_VolumeLevel_value_changed(value):
	set_volume(value)
	$TestSound.play()
