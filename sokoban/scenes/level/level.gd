extends Node2D

class_name Level

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		GameManager.load_main_scene()
		return

	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		return
