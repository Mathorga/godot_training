extends Control

class_name Hud

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var hearts_container: HBoxContainer = $MarginContainer/HeartsContainer

var _score: int = 0
var _hearts: Array[Node]

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		GameManager.load_main()

func _enter_tree() -> void:
	SignalHub.scored.connect(_on_scored)
	SignalHub.player_hit.connect(_on_player_hit)

func _ready() -> void:
	_hearts = hearts_container.get_children()

	# Fetch previous score from GameManager.
	_score = GameManager.cached_score
	_on_scored(_score)

func _exit_tree() -> void:
	GameManager.try_add_new_score(_score)

func _update_score_label() -> void:
	score_label.text = "%04d" % _score

func level_over(complete : bool) -> void:
	get_tree().paused = true

func _on_scored(points: int) -> void:
	_score += points
	_update_score_label()

func _on_player_hit(lives: int, shake: bool) -> void:
	for index in range(_hearts.size()):
		_hearts[index].visible = index < lives

	if lives <= 0:
		level_over(false)
