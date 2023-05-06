extends Button

func unlock():
	$Lock.queue_free()
	$Requirement.queue_free()

func _on_LevelSelectionButton_pressed():
	$Clicked.play()
