extends Node

signal create_bullet_requested(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType)
signal create_object_requested(pos: Vector2, obj_type: Constants.ObjectType)
signal scored(points: int)
signal boss_killed
signal player_hit(lives: int, shake: bool)

func emit_create_bullet_requested(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType) -> void:
	create_bullet_requested.emit(pos, dir, speed, obj_type)

func emit_create_object_requested(pos: Vector2, obj_type: Constants.ObjectType) -> void:
	create_object_requested.emit(pos, obj_type)

func emit_scored(points: int) -> void:
	scored.emit(points)

func emit_boss_killed() -> void:
	boss_killed.emit()

func emit_player_hit(lives: int, shake: bool) -> void:
	player_hit.emit(lives, shake)
