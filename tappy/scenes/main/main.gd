extends Control

class_name Main

@onready var b_right_label: Label = $MarginContainer/BRightLabel

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("power")):
		GameManager.load_game_scene()

func _ready() -> void:
	get_tree().paused = false
	b_right_label.text = "%03d" % ScoreManager.high_score
