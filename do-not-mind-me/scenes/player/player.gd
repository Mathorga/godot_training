extends CharacterBody2D
class_name Player

const SPEED: float = 150.0
const GROUP_NAME: String = "player"

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)

func _physics_process(_delta: float) -> void:
	var input_vec: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if input_vec.length() <= 0.0:
		return

	velocity = input_vec * SPEED

	rotation = velocity.angle()

	move_and_slide()
