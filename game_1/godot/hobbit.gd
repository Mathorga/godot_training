extends Node2D


class_name Hobbit


signal wizard_killed


@export var rotation_speed: float = PI


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up"):
		wizard_killed.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate(rotation_speed * delta)

func hit_by_spell() -> void:
	scale *= 0.5
	set_process(false)
