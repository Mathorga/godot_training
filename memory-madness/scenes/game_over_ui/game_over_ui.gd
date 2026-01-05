extends Control

@onready var moves_label: Label = $NinePatchRect/VBoxContainer/MovesLabel

func _enter_tree() -> void:
	SignalHub.game_over.connect(on_game_over)
	SignalHub.game_exit_pressed.connect(on_game_exit_pressed)

func _ready() -> void:
	hide()

func on_game_over(moves_count: int) -> void:
	show()
	moves_label.text = "Moves: %d" % moves_count

func on_game_exit_pressed() -> void:
	hide()
