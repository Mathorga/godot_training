extends Resource

class_name LevelsDataResource

@export var levels: Array[LevelSettingResource] = []

func get_levels_count() -> int:
	return levels.size()

func get_level_data(level: int) -> LevelSettingResource:
	for lvl in levels:
		if lvl.get_level_number() == level:
			return lvl

	return null
