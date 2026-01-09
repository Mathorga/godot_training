extends CharacterBody2D

class_name Player

const GRAVITY: Vector2 = Vector2(0.0, 981.0)
const JUMP_SPEED: float = 350.0
const RUN_SPEED: float = 100.0

@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity.
	# Here we're using delta because we're not setting the value of velocity directly,
	# rather we're increasing it by some amount that NEEDS to be scaled by delta: it's an acceleration.
	velocity += GRAVITY * delta

	# Move.
	velocity.x = Input.get_axis("left", "right") * RUN_SPEED;

	# Jump.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED

	flip_sprite()

	# Only apply movement after velocity has been updated.
	move_and_slide()

func flip_sprite() -> void:
	if is_zero_approx(velocity.x):
		return

	sprite_2d.flip_h = velocity.x < 0
