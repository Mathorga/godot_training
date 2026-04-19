extends Node

signal bullet_spawn_requested(pos: Vector2)
signal pickup_collected
signal show_exit_requested

func request_bullet_spawn(pos: Vector2) -> void:
	bullet_spawn_requested.emit(pos)

func emit_pickup_collected() -> void:
	pickup_collected.emit()

func request_show_exit() -> void:
	show_exit_requested.emit()
