extends Resource
class_name EnemyWaves

@export var waves: Array[EnemyWave]

func get_wave(index: int) -> EnemyWave:
	return waves[index % waves.size()]
