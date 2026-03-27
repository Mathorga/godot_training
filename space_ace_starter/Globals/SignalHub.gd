extends Node

signal player_hit(val: int)
signal player_health_restored(val: int)
signal player_died
signal on_score_updated(val: int)
signal create_explosion_requested(pos: Vector2, animation_name: String)
signal create_power_up_requested(pos: Vector2, type: PowerUp.PowerUpType)
signal create_bullet_requested(pos: Vector2, dir: Vector2, speed: float, type: BulletBase.BulletType)
signal create_homing_missile_requested(pos: Vector2)

func emit_player_hit(val: int) -> void:
	player_hit.emit(val)

func emit_player_health_restored(val: int) -> void:
	player_health_restored.emit(val)

func emit_player_died() -> void:
	player_died.emit()

func emit_on_score_updated(v: int) -> void:
	on_score_updated.emit(v)

func request_create_explosion(pos: Vector2, animation_name: String) -> void:
	create_explosion_requested.emit(pos, animation_name)

func request_create_power_up(pos: Vector2, type: PowerUp.PowerUpType) -> void:
	create_power_up_requested.emit(pos, type)

func request_create_rand_power_up(pos: Vector2) -> void:
	create_power_up_requested.emit(pos, PowerUp.PowerUpType.values().pick_random())

func request_create_bullet(pos: Vector2, dir: Vector2, speed: float, type: BulletBase.BulletType) -> void:
	create_bullet_requested.emit(pos, dir, speed, type)

func request_create_homing_missile(pos: Vector2) -> void:
	create_homing_missile_requested.emit(pos)
