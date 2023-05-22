extends Control

onready var musicBus = AudioServer.get_bus_index("Music")
onready var sfxBus = AudioServer.get_bus_index("SFX")

#load data
func _ready():
	$ConfirmPanel.set_text("Are you sure? This will wipe all your progress.")

func set_music_volume(v):
	AudioServer.set_bus_volume_db(musicBus, linear2db(v))
	
func set_sfx_volume(v):
	AudioServer.set_bus_volume_db(sfxBus, linear2db(v))
	$VBoxContainer/HBoxContainer/Sliders/SFXVolume/SFXTest.play()


func _on_ResetData_pressed():
	$ConfirmationBlock.set_deferred("visible", true)
	$ConfirmPanel.set_deferred("visible", true)

func _on_ConfirmPanel_confirm():
	SaveScript.reset()
	$ConfirmationBlock.set_deferred("visible", false)
	$ConfirmPanel.set_deferred("visible", false)


func _on_ConfirmPanel_back():
	$ConfirmationBlock.set_deferred("visible", false)


func _on_MusicSlider_value_changed(value):
	set_music_volume(value)


func _on_SFXSlider_value_changed(value):
	set_sfx_volume(value)
