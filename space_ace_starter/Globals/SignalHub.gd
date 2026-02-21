extends Node

signal on_player_hit(v: int)
signal on_score_updated(v: int)
signal create_explosion_requested(pos: Vector2, animation_name: String)

func emit_on_player_hit(v: int) -> void:
	on_player_hit.emit(v)

func emit_on_score_updated(v: int) -> void:
	on_score_updated.emit(v)

func emit_create_explosion_requested(pos: Vector2, animation_name: String) -> void:
	create_explosion_requested.emit(pos, animation_name)
