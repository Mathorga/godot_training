extends Node2D

class_name Level

const TILE_ATLAS_ID: int = 0

@onready var tile_layers: Node2D = $TileLayers
@onready var floor_tiles: TileMapLayer = $TileLayers/FloorTiles
@onready var wall_tiles: TileMapLayer = $TileLayers/WallTiles
@onready var target_tiles: TileMapLayer = $TileLayers/TargetTiles
@onready var box_tiles: TileMapLayer = $TileLayers/BoxTiles
@onready var camera: Camera2D = $Camera
@onready var player: AnimatedSprite2D = $Player

var _tile_size: int = 0
var _current_player_tile: Vector2i = Vector2i.ZERO

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		GameManager.load_main_scene()
		return

	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		return

	var move_dir: Vector2i = Vector2i.ZERO
	if Input.is_action_just_pressed("ui_left"):
		move_dir = Vector2i.LEFT
	elif Input.is_action_just_pressed("ui_right"):
		move_dir = Vector2i.RIGHT
	elif Input.is_action_just_pressed("ui_up"):
		move_dir = Vector2i.UP
	elif Input.is_action_just_pressed("ui_down"):
		move_dir = Vector2i.DOWN

	if not is_zero_approx(move_dir.x):
		player.flip_h = move_dir.x < 0

	if move_dir != Vector2i.ZERO:
		_move_player(move_dir)

func _is_cell_wall(cell_coord: Vector2i) -> bool:
	return cell_coord in wall_tiles.get_used_cells()

func _is_cell_box(cell_coord: Vector2i) -> bool:
	return cell_coord in box_tiles.get_used_cells()

func _is_cell_empty(cell_coord: Vector2i) -> bool:
	return not _is_cell_wall(cell_coord) and not _is_cell_box(cell_coord)

func _can_move_box(box_tile_coord: Vector2i, move_dir: Vector2i) -> bool:
	return _is_cell_empty(box_tile_coord + move_dir)

func _move_box(box_tile_coord: Vector2i, move_dir: Vector2i) -> void:
	var dst_tile_coord: Vector2i = box_tile_coord + move_dir
	box_tiles.erase_cell(box_tile_coord)

	var layer_type: TileLayers.LayerType = TileLayers.LayerType.TargetBoxes if dst_tile_coord in target_tiles.get_used_cells() else TileLayers.LayerType.Boxes
	box_tiles.set_cell(dst_tile_coord, TILE_ATLAS_ID, _get_atlas_coord(layer_type))

func _move_player(move_dir: Vector2i) -> void:
	var dst_tile_coord: Vector2i = _current_player_tile + move_dir

	# Check for wall hits.
	if _is_cell_wall(dst_tile_coord):
		return

	var is_dst_box: bool = _is_cell_box(dst_tile_coord)

	# Cannot move box, so cannot move at all.
	if is_dst_box and !_can_move_box(dst_tile_coord, move_dir):
		return

	if is_dst_box:
		_move_box(dst_tile_coord, move_dir)

	_place_player_on_tile(dst_tile_coord)

func _ready() -> void:
	_tile_size = floor_tiles.tile_set.tile_size.x

	_setup_level()
	_move_camera()

func _place_player_on_tile(tile_coord: Vector2i) -> void:
	_current_player_tile = tile_coord
	player.position = Vector2(tile_coord * _tile_size)

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

	_place_player_on_tile(level_layout.get_player_start())

func _move_camera() -> void:
	camera.position = floor_tiles.get_used_rect().get_center() * _tile_size
