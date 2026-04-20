extends Control
class_name GameUI

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var time_label: Label = $MarginContainer/TimeLabel
@onready var exit_label: Label = $MarginContainer/ExitLabel
@onready var game_over_rect: ColorRect = $GameOverRect
@onready var game_over_label: Label = $GameOverRect/GameOverLabel

var _pickups_count: int = 0
var _collected_pickups: int = 0
var _elapsed: float = 0.0

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		GameManager.load_main_scene()
		return

func _ready() -> void:
	SignalHub.pickup_collected.connect(_on_pickup_collected)
	SignalHub.exit_reached.connect(_on_exit_reached)
	SignalHub.player_died.connect(_on_player_died)
	get_tree().paused = false
	_pickups_count = get_tree().get_node_count_in_group(Pickup.GROUP_NAME)
	_update_score_label()

func _process(delta: float) -> void:
	_elapsed += delta
	time_label.text = "%.1fs" % _elapsed

func _update_score_label() -> void:
	score_label.text = "%d / %d" % [
		_collected_pickups,
		_pickups_count
	]

func _stop_game(message: String) -> void:
	set_process(false)
	get_tree().paused = true
	game_over_rect.show()
	game_over_label.text = message

func _on_pickup_collected() -> void:
	_collected_pickups += 1

	_update_score_label()

	if _collected_pickups >= _pickups_count:
		SignalHub.request_show_exit()
		exit_label.show()

func _on_exit_reached() -> void:
	_stop_game("LEVEL COMPLETED IN %.1fs" % _elapsed)

func _on_player_died() -> void:
	_stop_game("GAME OVER")
