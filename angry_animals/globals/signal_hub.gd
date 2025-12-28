extends Node

signal bird_died
signal attempt_made
signal cup_done(remaining_cups: int)

func emit_bird_died() -> void:
	bird_died.emit()

func emit_attempt_made() -> void:
	attempt_made.emit()

func emit_cup_done(remaining_cups: int) -> void:
	cup_done.emit(remaining_cups)
