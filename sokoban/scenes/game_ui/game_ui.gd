extends Control

class_name GameUI

@onready var level_label: Label = $MarginContainer/Labels/LevelInfoBox/LevelLabel
@onready var moves_label: Label = $MarginContainer/Labels/MovesInfoBox/MovesLabel
@onready var best_label: Label = $MarginContainer/Labels/BestInfoBox/BestLabel

func _ready() -> void:
	var level_number: int = GameManager.current_level

	level_label.text = "%d" % level_number
	moves_label.text = "0"

	if GameManager.current_has_level_score():
		best_label.text = "%d" % GameManager.current_get_best_score()

func set_moves_label(moves_count: int) -> void:
	moves_label.text = "%d" % moves_count

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
