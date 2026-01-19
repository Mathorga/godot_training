extends Area2D

class_name BaseBullet

var _direction: Vector2 = Vector2(50.0, -50.0)

func _enter_tree() -> void:
	area_entered.connect(on_area_entered)

func _process(delta: float) -> void:
	position += _direction * delta

func setup(pos: Vector2, dir: Vector2, speed: float) -> void:
	_direction = dir.normalized() * speed
	global_position = pos

func on_area_entered(_area: Area2D) -> void:
	queue_free()
