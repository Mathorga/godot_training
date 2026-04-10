extends CharacterBody2D
class_name NPC

const SPEED: float = 100.0

@onready var debug_label: Label = $DebugLabel
@onready var nav_agent: NavigationAgent2D = $NavAgent

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("set_target"):
		nav_agent.target_position = get_global_mouse_position()

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	_set_label()
	_navigate()

func _navigate() -> void:
	if nav_agent.is_navigation_finished(): return

	var next_pos: Vector2 = nav_agent.get_next_path_position()
	rotation = global_position.direction_to(next_pos).angle()
	velocity = transform.x * SPEED
	move_and_slide()

func _set_label() -> void:
	var label_content: String = ""
	label_content += "FD: %s\n" % nav_agent.is_navigation_finished()
	label_content += "T_RD: %s\n" % nav_agent.is_target_reached()
	label_content += "T_RBL: %s\n" % nav_agent.is_target_reachable()
	label_content += "T_POS: %s\n" % nav_agent.target_position
	debug_label.text = label_content
