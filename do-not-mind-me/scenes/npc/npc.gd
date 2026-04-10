extends CharacterBody2D
class_name NPC

enum EnemyState {
	patroling,
	chasing,
	searching
}

const SPEED: float = 100.0

@export var patrol_points: NodePath

@onready var debug_label: Label = $DebugLabel
@onready var nav_agent: NavigationAgent2D = $NavAgent

var _current_state: EnemyState = EnemyState.patroling
var _waypoints: Array[Vector2] = []
var _current_target: int = 0

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("set_target"):
		nav_agent.target_position = get_global_mouse_position()

func _ready() -> void:
	print(nav_agent.is_navigation_finished())
	_read_waypoints()

func _physics_process(_delta: float) -> void:
	_update_movement()
	_navigate()
	_set_label()

func _update_movement() -> void:
	match _current_state:
		EnemyState.patroling:
			_process_patroling()
		EnemyState.chasing:
			_process_chasing()
		EnemyState.searching:
			_process_searching()

func _process_patroling() -> void:
	if nav_agent.is_navigation_finished():
		_start_patrol()

func _process_chasing() -> void:
	pass

func _process_searching() -> void:
	pass

func _start_patrol() -> void:
	if _waypoints.is_empty(): return
	nav_agent.target_position = _waypoints[_current_target]
	_current_target += 1
	_current_target %= _waypoints.size()

func _read_waypoints() -> void:
	var patrol_points_node: Node = get_node(patrol_points)
	if patrol_points_node == null:
		return

	for child in patrol_points_node.get_children():
		# Just break if the current child is not a node2d.
		if not child is Node2D: break
		_waypoints.append(child.global_position)

func _navigate() -> void:
	if nav_agent.is_navigation_finished():
		return

	var next_pos: Vector2 = nav_agent.get_next_path_position()
	rotation = global_position.direction_to(next_pos).angle()
	velocity = transform.x * SPEED
	move_and_slide()

func _set_label() -> void:
	var label_content: String = ""
	label_content += "CS: %s\n" % EnemyState.keys()[_current_state]
	label_content += "FD: %s\n" % nav_agent.is_navigation_finished()
	label_content += "T_RD: %s\n" % nav_agent.is_target_reached()
	label_content += "T_RBL: %s\n" % nav_agent.is_target_reachable()
	label_content += "T_POS: %s\n" % nav_agent.target_position
	debug_label.text = label_content
