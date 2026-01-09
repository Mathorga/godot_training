extends CharacterBody2D

class_name Player

const GRAVITY: Vector2 = Vector2(0.0, 690)
const JUMP_FORCE: float = 250.0

func _physics_process(delta: float) -> void:
	# Move.
	velocity += GRAVITY * delta

	# Jump.
	jump()

	move_and_slide()

func jump() -> void:
	if not is_on_floor():
		return

	if not Input.is_action_just_pressed("jump"):
		return

	print("NANONE")
	velocity.y = -JUMP_FORCE
