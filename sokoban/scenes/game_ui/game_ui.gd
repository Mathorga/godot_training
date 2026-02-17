extends Control

class_name GameUI

@onready var level_label: Label = $MarginContainer/Labels/LevelInfoBox/LevelLabel
@onready var moves_label: Label = $MarginContainer/Labels/MovesInfoBox/MovesLabel
@onready var best_label: Label = $MarginContainer/Labels/BestInfoBox/BestLabel
@onready var game_over: NinePatchRect = $GameOver
@onready var high_score_label: Label = $GameOver/MarginContainer/VBoxContainer/VBoxContainer/HighScoreLabel
@onready var moves_done_label: Label = $GameOver/MarginContainer/VBoxContainer/VBoxContainer/MovesDoneLabel

func _ready() -> void:
	var level_number: int = GameManager.current_level

	level_label.text = "%d" % level_number
	moves_label.text = "0"

	if GameManager.current_has_level_score():
		best_label.text = "%d" % GameManager.current_get_best_score()

	game_over.hide()

func set_moves_label(moves_count: int) -> void:
	moves_label.text = "%d" % moves_count

func show_game_over(moves_count: int, is_best: bool) -> void:
	game_over.show()

	moves_done_label.text = "in %d moves" % moves_count
	high_score_label.visible = is_best

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
