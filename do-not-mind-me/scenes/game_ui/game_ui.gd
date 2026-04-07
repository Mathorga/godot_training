extends Control
class_name GameUI

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		GameManager.load_main_scene()
		return
