extends Node

signal level_selected(level_number: int)
signal game_exit_pressed
signal tile_selected(tile: MemoryTile)
signal game_over(moves_count: int)

func emit_level_selected(level_number: int) -> void:
	level_selected.emit(level_number)

func emit_game_exit_pressed() -> void:
	game_exit_pressed.emit()

func emit_tile_selected(tile: MemoryTile) -> void:
	tile_selected.emit(tile)

func emit_game_over(moves_count: int) -> void:
	game_over.emit(moves_count)
