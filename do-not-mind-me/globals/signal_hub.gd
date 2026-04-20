extends Node

signal bullet_spawn_requested(pos: Vector2)
signal boom_spawn_requested(pos: Vector2)
signal pickup_collected
signal show_exit_requested
signal exit_reached
signal player_died

func request_bullet_spawn(pos: Vector2) -> void:
	bullet_spawn_requested.emit(pos)

func request_boom_spawn(pos: Vector2) -> void:
	boom_spawn_requested.emit(pos)

func emit_pickup_collected() -> void:
	pickup_collected.emit()

func request_show_exit() -> void:
	show_exit_requested.emit()

func emit_exit_reached() -> void:
	exit_reached.emit()

func emit_player_died() -> void:
	player_died.emit()
