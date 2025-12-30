extends Object

class_name LevelDataSelector

const LEVELS_DATA: LevelsDataResource = preload("uid://b71y22yjcoo2v")

static func get_level_setting(level: int) -> LevelSettingResource:
	return LEVELS_DATA.get_level_data(level)
