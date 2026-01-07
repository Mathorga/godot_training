extends Control

class_name Game

const MEMORY_TILE: PackedScene = preload("uid://v3bn5nusx3tk")

@onready var exit_button: TextureButton = $HBoxContainer/MarginContainer/VBoxContainer/ExitButton
@onready var grid_container: GridContainer = $HBoxContainer/GridContainer
@onready var sound: AudioStreamPlayer = $Sound
@onready var scorer: Scorer = $Scorer
@onready var moves_count_label: Label = $HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/MovesCountLabel
@onready var pairs_count_label: Label = $HBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/PairsCountLabel

#region overrides

func _enter_tree() -> void:
	SignalHub.level_selected.connect(on_level_selected)

func _ready() -> void:
	exit_button.pressed.connect(on_exit_pressed)

func _process(_delta: float) -> void:
	moves_count_label.text = scorer.get_moves_made_str()
	pairs_count_label.text = scorer.get_pairs_made_str()

#endregion

func add_mem_tile(item_image: Texture2D, frame_image: Texture2D) -> void:
	var mem_tile: MemoryTile = MEMORY_TILE.instantiate()
	grid_container.add_child(mem_tile)
	mem_tile.setup(item_image, frame_image)

#region signal_callbacks

func on_exit_pressed() -> void:
	# Remove all tiles.
	for mem_tile in grid_container.get_children():
		mem_tile.queue_free()

	SoundManager.play_button_click(sound)
	SignalHub.emit_game_exit_pressed()

func on_level_selected(level_number: int) -> void:
	var lds: LevelDataSelector = LevelDataSelector.get_level_selection(level_number)

	var frame_image: Texture2D = ImageManager.get_random_frame_image()

	grid_container.columns = lds.get_cols()
	for item_image in lds.get_selected_images():
		add_mem_tile(item_image, frame_image)

	scorer.clear_new_game(lds.get_target_pairs())

#endregion
