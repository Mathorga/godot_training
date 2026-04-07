extends Control
class_name Main

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		GameManager.load_level_scene()
		return
