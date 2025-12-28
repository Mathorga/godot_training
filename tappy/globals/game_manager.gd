extends Node

const MAIN_SCENE: Resource = preload("uid://bk7wx4bliuk8n")
const GAME_SCENE: Resource = preload("uid://cmvi8rt67bmrw")
const SIMPLE_TRANSITION = preload("uid://5mfm72j4xalr")
const COMPLEX_TRANSITION = preload("uid://bgqg86nsd28e2")

var next_scene: PackedScene
var complex_trans: ComplexTransition

func _ready() -> void:
	complex_trans = COMPLEX_TRANSITION.instantiate()
	add_child(complex_trans)

func start_transition(to_scene: PackedScene) -> void:
	next_scene = to_scene
	complex_trans.play_animation()

func load_main_scene() -> void:
	#next_scene = MAIN_SCENE
	#get_tree().change_scene_to_packed(SIMPLE_TRANSITION)

	start_transition(MAIN_SCENE)

func load_game_scene() -> void:
	#next_scene = GAME_SCENE
	#get_tree().change_scene_to_packed(SIMPLE_TRANSITION)

	start_transition(GAME_SCENE)

func change_to_next() -> void:
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
