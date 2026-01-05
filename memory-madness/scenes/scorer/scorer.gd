extends Node

class_name Scorer

static var selection_enabled: bool = true

@onready var sound: AudioStreamPlayer = $Sound
@onready var reveal_timer: Timer = $RevealTimer

var selections: Array[MemoryTile] = []
var target_pairs: int = 0
var moves_made: int = 0
var pairs_made: int = 0

#region overrides

func _enter_tree() -> void:
	SignalHub.tile_selected.connect(on_tile_selected)
	SignalHub.game_exit_pressed.connect(on_game_exit_pressed)

func _ready() -> void:
	reveal_timer.timeout.connect(on_reveal_timer_timeout)

#endregion

func clear_new_game(pairs: int) -> void:
	selection_enabled = true
	selections.clear()
	target_pairs = pairs
	moves_made = 0
	pairs_made = 0

func check_for_pair() -> void:
	moves_made += 1

	if not selections[0].matches(selections[1]):
		return

	pairs_made += 1
	for tile in selections:
		tile.kill()

	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)

func process_pair() -> void:
	if selections.size() < 2:
		return

	selection_enabled = false
	reveal_timer.start()

	# Check for actual pairs.
	check_for_pair()

func check_game_over() -> void:
	if pairs_made == target_pairs:
		selection_enabled = false
		SignalHub.emit_game_over(moves_made)
	else:
		selection_enabled = true

func get_moves_made_str() -> String:
	return "%d" % moves_made

func get_pairs_made_str() -> String:
	return "%d/%d" % [pairs_made, target_pairs]

#region signal_callbacks

func on_tile_selected(tile: MemoryTile) -> void:
	if tile in selections:
		return

	tile.reveal(true)
	selections.append(tile)
	SoundManager.play_button_click(sound)
	process_pair()

func on_game_exit_pressed() -> void:
	reveal_timer.stop()

func on_reveal_timer_timeout() -> void:
	# Hide all tiles.
	for tile in selections:
		tile.reveal(false)

	# Clear selection.
	selections.clear()

	check_game_over()

#endregion
