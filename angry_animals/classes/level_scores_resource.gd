extends Resource

class_name LevelScoresResource

const DEFAULT_SCORE: int = -1

@export var scores: Dictionary[String, int] = {}

func get_level_score(level: String) -> int:
	return scores.get(level, DEFAULT_SCORE)

func update_level_score(level: String, score: int) -> void:
	var current_score: int = get_level_score(level)
	if current_score == -1 or score < current_score:
		scores.set(level, score)

func level_exists(level: String) -> bool:
	return level in scores
