extends Control
class_name GameOverUI

@export var wait_time: float = 2.0

@onready var score_label: Label = $VBoxContainer/ScoreLabel

var _can_continue: bool = false

func _enter_tree() -> void:
	SignalHub.player_died.connect(_on_player_died)

func _unhandled_input(event: InputEvent) -> void:
	if _can_continue and event.is_action_pressed("shoot"):
		GameManager.load_main_scene()
		return
	if Input.is_action_just_pressed("exit"):
		get_tree().paused = not get_tree().paused

func _ready() -> void:
	hide()
	get_tree().paused = false

func _on_player_died() -> void:
	get_tree().paused = true
	show()
	await get_tree().create_timer(wait_time).timeout
	_can_continue = true
	score_label.text = "SCORE: %d (Best: %d)" % [
		ScoreManager.score,
		ScoreManager.high_score
	]
	score_label.show()
