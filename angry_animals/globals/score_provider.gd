extends Node

const SCORES_PATH: String = "user://animals_save.tres"

var level_scores: LevelScoresResource

var selected_level: String = "":
	get:
		return selected_level
	set (value):
		selected_level = value

func _ready() -> void:
	load_scores()

func load_scores() -> void:
	if ResourceLoader.exists(SCORES_PATH):
		level_scores = load(SCORES_PATH)

	if level_scores == null:
		level_scores = LevelScoresResource.new()

func store_scores() -> void:
	ResourceSaver.save(level_scores, SCORES_PATH)

func get_level_score(level: String) -> int:
	return level_scores.get_level_score(level)

func set_level_score(level: String, score: int) -> void:
	level_scores.update_level_score(level, score)
	store_scores()
