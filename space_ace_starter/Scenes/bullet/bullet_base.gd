extends Projectile
class_name BulletBase

enum BulletType {
	player,
	enemy,
	bomb
}

var _dir: Vector2 = Vector2.UP
var _spd: float = 20.0

func _process(delta: float) -> void:
	position += _dir * _spd * delta

func setup(direction: Vector2, speed: float) -> void:
	_dir = direction.normalized()
	_spd = speed
	rotate((PI / 2) + direction.angle())

func blow_up() -> void:
	SignalHub.emit_create_explosion_requested(global_position, Explosion.EXPLODE)
	super()
