extends Control

var data = {}

var save_path = preload("res://scripts/SaveScript.gd")
var SaveObject = null

#load data
func _ready():
	SaveObject = save_path.new()
	data = SaveObject.load_data()
	$ConfirmPanel.set_text("Are you sure? This will wipe all your progress.")

func set_volume(volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), (-50 + volume*100/7))


func _on_VolumeLevel_value_changed(value):
	set_volume(value)
	$TestSound.play()


func _on_ResetData_pressed():
	$ConfirmationBlock.set_deferred("visible", true)
	$ConfirmPanel.set_deferred("visible", true)

func _on_ConfirmPanel_confirm():
	SaveObject.reset()
	$ConfirmationBlock.set_deferred("visible", false)
	$ConfirmPanel.set_deferred("visible", false)


func _on_ConfirmPanel_back():
	$ConfirmationBlock.set_deferred("visible", false)
