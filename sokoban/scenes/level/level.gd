extends Node2D

class_name Level

const TILE_ATLAS_ID: int = 0

@onready var tile_layers: Node2D = $TileLayers
@onready var floor_tiles: TileMapLayer = $TileLayers/FloorTiles
@onready var wall_tiles: TileMapLayer = $TileLayers/WallTiles
@onready var target_tiles: TileMapLayer = $TileLayers/TargetTiles
@onready var box_tiles: TileMapLayer = $TileLayers/BoxTiles
@onready var camera: Camera2D = $Camera

var _tile_size: int = 0

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		GameManager.load_main_scene()
		return

	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		return

func _ready() -> void:
	_tile_size = floor_tiles.tile_set.tile_size.x

	_setup_level()

func _get_atlas_coord(layer_type: TileLayers.LayerType) -> Vector2i:
	match(layer_type):
		TileLayers.LayerType.Floor:
			return Vector2i(randi_range(3, 8), 0)
		TileLayers.LayerType.Walls:
			return Vector2i(2, 0)
		TileLayers.LayerType.Targets:
			return Vector2i(9, 0)
		TileLayers.LayerType.TargetBoxes:
			return Vector2i(0, 0)
		TileLayers.LayerType.Boxes:
			return Vector2i(1, 0)
		_:
			return Vector2i.ZERO

func _add_tile(layer_type: TileLayers.LayerType, tile_coord: Vector2i, tile_layer: TileMapLayer) -> void:
	tile_layer.set_cell(tile_coord, TILE_ATLAS_ID, _get_atlas_coord(layer_type))

func _setup_layer(layer_type: TileLayers.LayerType, tile_layer: TileMapLayer, level_layout: LevelLayout) -> void:
	var layer_tile_coords: Array[Vector2i] = level_layout.get_tiles_for_layer(layer_type)
	for layer_tile_coord in layer_tile_coords:
		_add_tile(layer_type, layer_tile_coord, tile_layer)

func _clear_tiles() -> void:
	for tile_layer in tile_layers.get_children():
		tile_layer.clear()

func _setup_level() -> void:
	var level_num: int = GameManager.current_level
	var level_layout: LevelLayout = LevelData.get_level_data("%d" % level_num)
	_clear_tiles()

	_setup_layer(TileLayers.LayerType.Floor, floor_tiles, level_layout)
	_setup_layer(TileLayers.LayerType.Walls, wall_tiles, level_layout)
	_setup_layer(TileLayers.LayerType.Targets, target_tiles, level_layout)
	_setup_layer(TileLayers.LayerType.Boxes, box_tiles, level_layout)
	_setup_layer(TileLayers.LayerType.TargetBoxes, box_tiles, level_layout)
