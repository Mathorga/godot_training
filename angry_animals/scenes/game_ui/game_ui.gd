extends Control

@onready var level_label: Label = $MarginContainer/HUDVBox/LevelLabel
@onready var attempts_label: Label = $MarginContainer/HUDVBox/AttemptsLabel
@onready var level_over_v_box: VBoxContainer = $MarginContainer/LevelOverVBox
@onready var music: AudioStreamPlayer = $Music

var attempts: int = 0

func _enter_tree() -> void:
	# Connect signals.
	SignalHub.attempt_made.connect(on_attempt_made)
	SignalHub.cup_done.connect(on_cup_done)

func _ready() -> void:
	level_over_v_box.hide()

	level_label.text = "Level %s" % ScoreProvider.selected_level
	update_attempts_label()

func update_attempts_label() -> void:
	attempts_label.text = "Attempt %d" % attempts

func on_attempt_made() -> void:
	attempts += 1
	update_attempts_label()

func on_cup_done(remaining_cups: int) -> void:
	if remaining_cups <= 0:
		music.play()
		level_over_v_box.show()
		ScoreProvider.set_level_score(ScoreProvider.selected_level, attempts)
