extends Button

onready var og_size = self.get_rect().size
var grow_size = Vector2(1.1,1.1)


func _on_LevelSelectionButton_mouse_entered():
	scale_btn(grow_size,.1)


func _on_LevelSelectionButton_mouse_exited():
	scale_btn(og_size,.1)


func scale_btn(end_size: Vector2, duration: float) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_size, duration)

func unlock():
	$Lock.queue_free()


func _on_LevelSelectionButton_pressed():
	$Clicked.play()
