extends Node

const MAIN = preload("uid://c1x11suqh7ksx")
const LEVEL_BASE = preload("uid://b3sqac532wkps")

const SCORES_PATH = "user://high_scores.tres"

var high_scores: HighScores = HighScores.new()

# score to carry over between levels
var cached_score: int:
	set (value):
		cached_score = value
	get:
		return cached_score

func _input(_event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_Q):
		get_tree().quit()

func _ready() -> void:
	load_high_scores()

func _exit_tree() -> void:
	save_high_scores()

func load_main() -> void:
	cached_score = 0
	get_tree().change_scene_to_packed(MAIN)

func load_next_level() -> void:
	get_tree().change_scene_to_packed(LEVEL_BASE)

func load_high_scores() -> void:
	if ResourceLoader.exists(SCORES_PATH):
		high_scores = load(SCORES_PATH)

func save_high_scores() -> void:
	ResourceSaver.save(high_scores, SCORES_PATH)

# try this each time game is over / level complete
func try_add_new_score(score: int) -> void:
	high_scores.add_new_score(score)
	save_high_scores()	
	cached_score = score
