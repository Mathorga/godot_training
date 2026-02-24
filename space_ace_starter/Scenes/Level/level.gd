extends Node2D

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		SignalHub.emit_create_explosion_requested(Vector2(100.0, 100.0), Explosion.EXPLODE)
