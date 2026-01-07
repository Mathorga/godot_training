extends Object

class_name LevelDataSelector

const LEVELS_DATA: LevelsDataResource = preload("uid://b71y22yjcoo2v")

#region static

static func get_level_setting(level: int) -> LevelSettingResource:
	return LEVELS_DATA.get_level_data(level)

static func get_level_selection(level_number: int) -> LevelDataSelector:
	var setting: LevelSettingResource = get_level_setting(level_number)

	if setting == null:
		return null

	ImageManager.shuffle_images()

	# Setup pairs of images.
	var images: Array[Texture2D] = []
	for i in range(setting.get_target_pairs()):
		images.append(ImageManager.get_image_at(i))
		images.append(ImageManager.get_image_at(i))

	images.shuffle()

	return LevelDataSelector.new(setting, images)

#endregion

var selected_images: Array[Texture2D] = []
var level_setting: LevelSettingResource

func _init(setting: LevelSettingResource, images: Array[Texture2D]) -> void:
	selected_images = images
	level_setting = setting

func get_selected_images() -> Array[Texture2D]:
	return selected_images

func get_target_pairs() -> int:
	return level_setting.get_target_pairs()

func get_cols() -> int:
	return level_setting.get_cols()
