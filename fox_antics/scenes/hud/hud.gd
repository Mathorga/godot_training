extends Control

class_name Hud

@onready var score_label: Label = $MarginContainer/ScoreLabel

var _score: int = 0

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		GameManager.load_main()

func _enter_tree() -> void:
	SignalHub.scored.connect(_on_scored)

func _ready() -> void:
	# Fetch previous score from GameManager.
	_score = GameManager.cached_score
	_on_scored(_score)

func _exit_tree() -> void:
	GameManager.try_add_new_score(_score)

func _update_score_label() -> void:
	score_label.text = "%04d" % _score

func _on_scored(points: int) -> void:
	_score += points
	_update_score_label()
