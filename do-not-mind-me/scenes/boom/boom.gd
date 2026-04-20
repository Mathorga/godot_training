extends Node2D
class_name Boom

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(_anim_name: StringName) -> void:
	queue_free()
