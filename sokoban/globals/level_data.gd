extends Node

const LEVEL_DATA_PATH: String = "res://data/level_data.json"

var _level_data: Dictionary = {}

func _enter_tree() -> void:
	load_level_data()

func load_level_data() -> void:
	var file: FileAccess = FileAccess.open(LEVEL_DATA_PATH, FileAccess.READ)
	if file == null:
		return

	var data_string: String = file.get_as_text()
	var data: Dictionary = JSON.parse_string(data_string)

	for level_num in data.keys():
		var level_data: Dictionary = data[level_num]
		setup_level(level_num, level_data)

func setup_level(level_num: String, raw_level_data: Dictionary) -> LevelLayout:
	var layout: LevelLayout = LevelLayout.new()
	var raw_tiles: Dictionary = raw_level_data.tiles
	var player_start: Dictionary = raw_level_data.player_start

	add_tiles_for_layer(layout, TileLayers.LayerType.Targets, raw_tiles.Targets)

	return layout

func add_tiles_for_layer(layout: LevelLayout, layer_type: TileLayers.LayerType, tile_coords: Array[Dictionary]) -> void:
	pass
