extends Node

signal level_selected(level_number: int)
signal game_exit_pressed

func emit_level_selected(level_number: int) -> void:
	level_selected.emit(level_number)

func emit_game_exit_pressed() -> void:
	game_exit_pressed.emit()
