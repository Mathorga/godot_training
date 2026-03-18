extends Node2D

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot"):
		#SignalHub.emit_create_explosion_requested(Vector2(100.0, 100.0), Explosion.EXPLODE)
		#SignalHub.request_create_rand_power_up(Vector2(100.0, 100.0))
		SignalHub.request_create_bullet(
			Vector2(315.0, 200.0),
			Vector2.DOWN,
			100.0,
			BulletBase.BulletType.bomb
		)
 
