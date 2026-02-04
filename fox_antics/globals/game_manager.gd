extends Node

const MAIN: PackedScene = preload("uid://c1x11suqh7ksx")
const LEVEL_BASE: PackedScene = preload("uid://b3sqac532wkps")

const LEVELS: Array[PackedScene] = [
	preload("uid://dr882ljmoa662"),
	preload("uid://eblw2oi36xkl")
]

const SCORES_PATH = "user://high_scores.tres"

var high_scores: HighScores = HighScores.new()
var _current_level: int = -1

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

func load_scene(scene: PackedScene) -> void:
	get_tree().paused = false
	get_tree().change_scene_to_packed(scene)

func load_main() -> void:
	cached_score = 0
	_current_level = -1
	load_scene(MAIN)

func load_next_level() -> void:
	_current_level = (_current_level + 1) % LEVELS.size()
	load_scene(LEVELS[_current_level])

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
