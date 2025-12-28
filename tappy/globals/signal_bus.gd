extends Node

signal on_tappy_died
signal on_point_scored

func emit_on_tappy_died_signal() -> void:
	on_tappy_died.emit()

func emit_on_point_scored_signal() -> void:
	on_point_scored.emit()
