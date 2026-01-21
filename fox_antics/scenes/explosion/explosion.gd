extends AnimatedSprite2D

class_name Explosion

func _enter_tree() -> void:
	animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	queue_free()
