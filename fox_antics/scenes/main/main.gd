extends Control

const HIGHSCORE_DISPLAY: PackedScene = preload("uid://dunl7ftjkjt3i")

@onready var grid_container: GridContainer = $MarginContainer/GridContainer

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		GameManager.load_next_level()

func _ready() -> void:
	get_tree().paused = false
	_set_scores()

func _set_scores() -> void:
	for score: HighScore in GameManager.high_scores.get_scores_list():
		var hsd: HighscoreDisplay = HIGHSCORE_DISPLAY.instantiate()
		hsd.setup(score)
		grid_container.add_child(hsd)
