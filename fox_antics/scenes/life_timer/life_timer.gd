extends Node

@export var life_time: float = 20.0

func _ready() -> void:
	await get_tree().create_timer(life_time).timeout

	# Delete the parent scene.
	get_parent().call_deferred("queue_free")
