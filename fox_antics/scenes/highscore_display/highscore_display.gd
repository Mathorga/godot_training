extends VBoxContainer

class_name HighscoreDisplay

@onready var score_label: Label = $ScoreLabel
@onready var time_label: Label = $TimeLabel

var _high_score: HighScore = null

func _ready() -> void:
	if _high_score == null:
		queue_free()
		return

	score_label.text = "%04d" % _high_score.score
	time_label.text = _high_score.date_scored
	_run_tween()

func _run_tween() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 1.5)

func setup(high_score: HighScore) -> void:
	_high_score = high_score
