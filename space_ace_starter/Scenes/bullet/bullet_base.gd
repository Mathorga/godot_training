extends Projectile
class_name BulletBase

enum BulletType {
	player,
	enemy,
	bomb
}

var _dir: Vector2 = Vector2.ZERO
var _spd: float

func setup(direction: Vector2, speed: float) -> void:
	_dir = direction.normalized()
	_spd = speed
	rotate(PI - direction.angle())

func _process(delta: float) -> void:
	position += _dir * _spd * delta
