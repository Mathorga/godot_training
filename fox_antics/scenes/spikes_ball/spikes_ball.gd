extends PathFollow2D

## Move speed in pixels/s.
@export var move_speed: float = 50.0

## Rotation speed in degrees/s.
@export var spin_speed: float = 360.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += move_speed * delta
	rotation_degrees += spin_speed * delta
