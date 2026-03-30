extends Node2D
class_name SaucerManager

const WAIT_TIME: float = 4.0
const WAIT_VAR: float = 0.5

const SAUCER_SCENE: PackedScene = preload("uid://d184ndmgjug8p")

@onready var paths: Node2D = $Paths
@onready var spawn_timer: Timer = $SpawnTimer

var _paths: Array[Path2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)

	for path in paths.get_children():
		_paths.append(path)

	_reset_timer()

func _reset_timer() -> void:
	SpaceUtils.set_and_start_timer(spawn_timer, WAIT_TIME, WAIT_VAR)

func _spawn_saucer() -> void:
	var saucer: Saucer = SAUCER_SCENE.instantiate()
	var path: Path2D = _paths.pick_random()
	path.add_child(saucer)
	_reset_timer()

func _on_spawn_timer_timeout() -> void:
	_spawn_saucer()
