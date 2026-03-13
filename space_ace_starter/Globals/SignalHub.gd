extends Node

signal on_player_hit(v: int)
signal on_score_updated(v: int)
signal create_explosion_requested(pos: Vector2, animation_name: String)
signal create_power_up_requested(pos: Vector2, type: PowerUp.PowerUpType)
signal create_bullet_requested(pos: Vector2, dir: Vector2, speed: float, type: BulletBase.BulletType)

func emit_on_player_hit(v: int) -> void:
	on_player_hit.emit(v)

func emit_on_score_updated(v: int) -> void:
	on_score_updated.emit(v)

func emit_create_explosion_requested(pos: Vector2, animation_name: String) -> void:
	create_explosion_requested.emit(pos, animation_name)

func request_create_power_up(pos: Vector2, type: PowerUp.PowerUpType) -> void:
	create_power_up_requested.emit(pos, type)

func request_create_rand_power_up(pos: Vector2) -> void:
	create_power_up_requested.emit(pos, PowerUp.PowerUpType.values().pick_random())

func request_create_bullet(pos: Vector2, dir: Vector2, speed: float, type: BulletBase.BulletType) -> void:
	create_bullet_requested.emit(pos, dir, speed, type)
