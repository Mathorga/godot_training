extends Node2D

class_name Level

@onready var tile_layers: Node2D = $TileLayers
@onready var floor_tiles: TileMapLayer = $TileLayers/FloorTiles
@onready var wall_tiles: TileMapLayer = $TileLayers/WallTiles
@onready var target_tiles: TileMapLayer = $TileLayers/TargetTiles
@onready var box_tiles: TileMapLayer = $TileLayers/BoxTiles
@onready var camera: Camera2D = $Camera

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		GameManager.load_main_scene()
		return

	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()
		return

func _ready() -> void:
	floor_tiles.clear()
	wall_tiles.clear()
	target_tiles.clear()
	box_tiles.clear()
