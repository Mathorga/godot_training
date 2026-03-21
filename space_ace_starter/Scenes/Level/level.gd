extends Node2D
class_name Level

#func _unhandled_input(_event: InputEvent) -> void:
	#if Input.is_action_just_pressed("shoot"):
		#SignalHub.request_create_explosion(Vector2(100.0, 100.0), Explosion.EXPLODE)
		#SignalHub.request_create_rand_power_up(Vector2(100.0, 100.0))
		#SignalHub.request_create_power_up(Vector2(315.0, 200.0),PowerUp.PowerUpType.shield)
		#SignalHub.request_create_power_up(Vector2(315.0, 100.0),PowerUp.PowerUpType.health)
		#SignalHub.request_create_bullet(Vector2(315.0, 150.0), Vector2.DOWN, 100.0, BulletBase.BulletType.player)
		#SignalHub.request_create_bullet(Vector2(315.0, 200.0), Vector2.LEFT, 100.0, BulletBase.BulletType.enemy)
		#SignalHub.request_create_bullet(Vector2(315.0, 250.0), Vector2.DOWN, 100.0, BulletBase.BulletType.enemy)
