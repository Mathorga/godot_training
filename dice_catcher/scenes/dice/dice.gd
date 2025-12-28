extends Area2D

class_name Dice

signal game_over

const SPEED: float = 100.0
const ROT_SPEED: float = 4.0

@onready var sprite_2d: Sprite2D = $Sprite2D

# 1 means CW, -1 means CCW.
var _rot_dir: int = 1

func _ready() -> void:
	_rot_dir = -1 if randf() < 0.5 else 1

func _physics_process(delta: float) -> void:
	sprite_2d.rotate(ROT_SPEED * delta * _rot_dir)
	translate(Vector2(0.0, SPEED * delta))
	_check_game_over()

func _check_game_over() -> void:
	if position.y - sprite_2d.texture.get_height() / 2 > get_viewport_rect().end.y:
		game_over.emit()
		queue_free()
