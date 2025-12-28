extends Node2D

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Speed in pixels/s.
var speed: float = 50.0

# Current moving direction.
var dir: int = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
		dir = -1
		sprite.flip_h = true

	if ray_cast_left.is_colliding():
		dir = 1
		sprite.flip_h = false

	position.x += dir * speed * delta
