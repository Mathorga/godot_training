extends Control

class_name Hud

const GAME_OVER_SOUND: Resource = preload("uid://cnqxcujxyyiws")
const LEVEL_COMPLETE_SOUND: Resource = preload("uid://br7ks6ypdp6he")

@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var hearts_container: HBoxContainer = $MarginContainer/HeartsContainer
@onready var complete_timer: Timer = $CompleteTimer
@onready var color_rect: ColorRect = $ColorRect
@onready var game_over_ui: VBoxContainer = $ColorRect/GameOverUI
@onready var level_complete_ui: VBoxContainer = $ColorRect/LevelCompleteUI
@onready var sound: AudioStreamPlayer = $Sound

var _score: int = 0
var _hearts: Array[Node]
var _can_continue: bool = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		GameManager.load_main()

	if not _can_continue:
		return

	if Input.is_action_just_pressed("shoot"):
		GameManager.load_main()

func _enter_tree() -> void:
	SignalHub.scored.connect(_on_scored)
	SignalHub.player_hit.connect(_on_player_hit)
	SignalHub.level_complete.connect(_on_level_complete)

func _ready() -> void:
	# Connect to signals.
	complete_timer.timeout. connect(_on_connect_timer_timeout)

	_hearts = hearts_container.get_children()

	# Fetch previous score from GameManager.
	_score = GameManager.cached_score
	_on_scored(_score)

func _exit_tree() -> void:
	GameManager.try_add_new_score(_score)

func _update_score_label() -> void:
	score_label.text = "%04d" % _score

func _on_level_complete(complete: bool) -> void:
	color_rect.visible = true
	game_over_ui.visible = not complete
	level_complete_ui.visible = complete
	sound.stream = LEVEL_COMPLETE_SOUND if complete else GAME_OVER_SOUND
	sound.play()
	complete_timer.start()
	get_tree().paused = true

func _on_scored(points: int) -> void:
	_score += points
	_update_score_label()

func _on_player_hit(lives: int, shake: bool) -> void:
	for index in range(_hearts.size()):
		_hearts[index].visible = index < lives

	if lives <= 0:
		_on_level_complete(false)

func _on_connect_timer_timeout() -> void:
	_can_continue = true
