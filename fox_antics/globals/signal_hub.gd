extends Node

signal create_bullet_requested(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType)
signal create_object_requested(pos: Vector2, obj_type: Constants.ObjectType)

func emit_create_bullet_requested(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType) -> void:
	create_bullet_requested.emit(pos, dir, speed, obj_type)

func emit_create_object_requested(pos: Vector2, obj_type: Constants.ObjectType) -> void:
	create_object_requested.emit(pos, obj_type)
