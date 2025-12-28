extends Control

class_name GameUI

@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel
@onready var game_over_sound: AudioStreamPlayer = $GameOverSound
@onready var game_over_timer: Timer = $GameOverTimer
@onready var score_label: Label = $MarginContainer/ScoreLabel

var _points: int = 0

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_cancel")):
		GameManager.load_main_scene()
	if event.is_action_pressed("power") and press_space_label.visible:
		GameManager.load_main_scene()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.on_tappy_died.connect(on_tappy_died)
	SignalBus.on_point_scored.connect(on_point_scored)
	update_score_label()

func on_tappy_died() -> void:
	game_over_sound.play()
	game_over_label.show()
	game_over_timer.start()
	ScoreManager.high_score = _points

func update_score_label() -> void:
	score_label.text = "%03d" % _points

func on_point_scored() -> void:
	_points += 1
	update_score_label()

func _on_game_over_timer_timeout() -> void:
	game_over_label.hide()
	press_space_label.show()
