extends Node

signal bullet_spawn_requested(pos: Vector2)

func request_bullet_spawn(pos: Vector2) -> void:
	bullet_spawn_requested.emit(pos)
