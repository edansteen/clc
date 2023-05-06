extends Panel

signal confirm
signal back

func set_text(s):
	$VBoxContainer/SureLabel.text = s

func _on_Confirm_pressed():
	emit_signal("confirm")


func _on_Back_pressed():
	self.set_deferred("visible", false)
	emit_signal("back")
