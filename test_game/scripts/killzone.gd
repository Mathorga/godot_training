extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("YOU DIED")
	Engine.time_scale = 0.1

	# Remove collider if present.
	var coll: CollisionShape2D = body.get_node("CollisionShape2D")
	if coll != null:
		coll.queue_free()

	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
