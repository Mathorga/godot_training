extends Node2D

class_name LevelBase

const BIRD_SCENE = preload("uid://52aa3w84urtt")

@onready var bird_position: Marker2D = $BirdPosition

func _ready() -> void:
	spawn_bird()

func _enter_tree() -> void:
	SignalHub.bird_died.connect(on_bird_died)

func spawn_bird() -> void:
	var bird: Bird = BIRD_SCENE.instantiate()
	bird.position = bird_position.position
	add_child(bird)

func on_bird_died() -> void:
	spawn_bird()
