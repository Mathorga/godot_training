extends Node2D
class_name WaveManager

const SPEED_FACTOR_INCREASE: float = 1.02
const WAVE_GAP_DECREASE: float = 0.97
const WAVES: EnemyWaves = preload("uid://cjhq33s48y0os")

@onready var paths: Node2D = $Paths
@onready var spawn_timer: Timer = $SpawnTimer

var _wave_count: int = 0
var _wave_gap: float = 4.0
var _speed_factor: float = 1.0
var _paths: Array[Path2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	for path in paths.get_children():
		_paths.append(path)
	spawn_wave()

func spawn_wave() -> void:
	var path: Path2D = _paths.pick_random()
	var wave: EnemyWave = WAVES.get_wave(_wave_count)

	for i in range(wave.number):
		var enemy: EnemyShip = wave.enemy_scene.instantiate()
		enemy.setup(wave.speed * _speed_factor)
		path.add_child(enemy)
		await get_tree().create_timer(wave.gap, false).timeout

	_wave_count += 1
	spawn_timer.start(_wave_gap)
	if _wave_count % WAVES.waves.size() == 0:
		_speed_factor *= SPEED_FACTOR_INCREASE
		_wave_gap *= WAVE_GAP_DECREASE

func _on_spawn_timer_timeout() -> void:
	spawn_wave()
