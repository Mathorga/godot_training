extends CharacterBody2D

class_name Player

const GRAVITY: Vector2 = Vector2(0.0, 981.0)
const JUMP_SPEED: float = 350.0
const RUN_SPEED: float = 100.0
const MAX_FALL_SPEED: float = 500.0

@export var fall_off_y: float = 1000.0 

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel

func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)

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

	velocity.y = clampf(velocity.y, -JUMP_SPEED, MAX_FALL_SPEED)

	# Only apply movement after velocity has been updated.
	move_and_slide()

	update_debug_label()

	check_fall_off()

func flip_sprite() -> void:
	if is_zero_approx(velocity.x):
		return

	sprite_2d.flip_h = velocity.x < 0

func update_debug_label() -> void:
	var debug_string: String = ""
	debug_string += "floor: %s \n" % is_on_floor()
	debug_string += "v: %.1f | %.1f\n" % [velocity.x, velocity.y]
	debug_string += "p: %.1f | %.1f" % [global_position.x, global_position.y]

	debug_label.text = debug_string

func check_fall_off() -> void:
	if global_position.y > fall_off_y:
		queue_free()
