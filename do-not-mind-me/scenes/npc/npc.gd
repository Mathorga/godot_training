extends CharacterBody2D
class_name NPC

enum EnemyState {
	patroling,
	chasing,
	searching
}

const SPEED: float = 100.0

## Field of view in degrees. This is computed left and right, so it actually counts as half fov.
const FOV: float = 60

@export var patrol_points: NodePath

@onready var debug_label: Label = $DebugLabel
@onready var nav_agent: NavigationAgent2D = $NavAgent
@onready var player_detector: RayCast2D = $PlayerDetector

var _current_state: EnemyState = EnemyState.patroling
var _waypoints: Array[Vector2] = []
var _current_target: int = 0
var _player: Player

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("set_target"):
		nav_agent.target_position = get_global_mouse_position()

func _ready() -> void:
	_player = get_tree().get_first_node_in_group(Player.GROUP_NAME)
	if _player == null: queue_free()

	_read_waypoints()

func _physics_process(_delta: float) -> void:
	_process_behavior()
	_move()
	_update_raycast()
	_set_label()

func _process_behavior() -> void:
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

func _update_raycast() -> void:
	player_detector.look_at(_player.global_position)

func _player_visible() -> bool:
	return player_detector.get_collider() is Player

func _can_see_player() -> bool:
	return _player_visible() and abs(_get_fov_angle()) < FOV

func _get_fov_angle() -> float:
	var dir_to_player: Vector2 = global_position.direction_to(_player.global_position)
	var angle_to_player: float = transform.x.angle_to(dir_to_player)
	return rad_to_deg(angle_to_player)

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

func _move() -> void:
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
	label_content += "P_VBL: %s\n" % _can_see_player()
	label_content += "FOV: %.0f\n" % _get_fov_angle()
	debug_label.text = label_content
