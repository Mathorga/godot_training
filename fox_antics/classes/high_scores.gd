extends Resource

class_name HighScores

const MAX_SCORES: int = 10

@export var high_scores: Array[HighScore] = []

func _init() -> void:
	sort_scores()

func compare_scores(a: HighScore, b: HighScore) -> bool:
	return a.score > b.score

func sort_scores() -> void:
	high_scores.sort_custom(compare_scores)

func get_scores_list() -> Array[HighScore]:
	return high_scores

func add_new_score(score: int) -> void:
	var new_high_score: HighScore = HighScore.new(score, Utils.formatted_dt())
	high_scores.append(new_high_score)
	sort_scores()
	if high_scores.size() > MAX_SCORES:
		high_scores.resize(MAX_SCORES)
