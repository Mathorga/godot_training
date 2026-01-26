extends PathFollow2D

class_name PFMovingPlatform

## Speed in pixels/s.
@export var speed: float = 50.0

func _physics_process(delta: float) -> void:
	progress += speed * delta
