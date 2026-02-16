extends Node

const MAIN_SCENE: PackedScene = preload("uid://dt12mjj45tb81")
const LEVEL_SCENE: PackedScene = preload("uid://3erogswmru6e")

var current_level: int = -1
var _best_scores: HighScoresResource

func _enter_tree() -> void:
	_best_scores = HighScoresResource.load_scores()

func get_best_score(level_number: int) -> int:
	return _best_scores.get_best_score("%d" % level_number)

func current_get_best_score() -> int:
	return _best_scores.get_best_score("%d" % current_level)

func has_level_score(level_num: String) -> bool:
	return _best_scores.has_level_score(level_num)

func current_has_level_score() -> bool:
	return _best_scores.has_level_score("%d" % current_level)

func set_level_completed(level_num: String, score: int) -> bool:
	return _best_scores.add_score(level_num, score)

func load_main_scene() -> void:
	current_level = -1

	get_tree().change_scene_to_packed(MAIN_SCENE)

func load_level_scene(level_number: int) -> void:
	if level_number > 0:
		current_level = level_number

	if current_level > 0:
		get_tree().change_scene_to_packed(LEVEL_SCENE)
