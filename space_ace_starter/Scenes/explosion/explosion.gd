extends Node2D

class_name Explosion

const BOOM: String = "boom"
const EXPLODE: String = "explode"

@onready var sprite: AnimatedSprite2D = $Sprite

var _anim_name: String = EXPLODE

func _ready() -> void:
	sprite.animation_finished.connect(_on_sprite_animation_finished)

	sprite.animation = _anim_name
	sprite.play()

func setup(anim_name: String) -> void:
	_anim_name = anim_name

func _on_sprite_animation_finished() -> void:
	queue_free()
