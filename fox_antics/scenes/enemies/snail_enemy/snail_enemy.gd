extends EnemyBase

class_name SnailEnemy

@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _physics_process(_delta: float) -> void:
	super._physics_process(_delta)

	velocity += gravity * _delta
	velocity.x = speed if animated_sprite_2d.flip_h else -speed

	move_and_slide()

	flip()

func flip() -> void:
	if is_on_wall() or not ray_cast_2d.is_colliding():
		animated_sprite_2d.flip_h = not animated_sprite_2d.flip_h
		ray_cast_2d.position.x = -ray_cast_2d.position.x
