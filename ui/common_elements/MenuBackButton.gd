extends Button

func _on_BackButton_pressed():
	get_parent().set_deferred("visible", false)
