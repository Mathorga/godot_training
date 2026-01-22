extends Area2D

class_name FruitPickup

@export var points: int = 2

@onready var anim: AnimatedSprite2D = $Anim
@onready var sound: AudioStreamPlayer2D = $Sound

func _enter_tree() -> void:
	area_entered.connect(_on_area_entered)

func _ready() -> void:
	sound.finished.connect(_on_sound_finished)

	var names: Array[String] = []

	for an_name in anim.sprite_frames.get_animation_names():
		names.append(an_name)

	anim.animation = names.pick_random()
	anim.play()

func _on_area_entered(_area: Area2D) -> void:
	# Hide the root node and stop the area2D from monitoring collisions.
	hide()
	set_deferred("monitoring", false)

	# Then play the collect sound.
	sound.play()

func _on_sound_finished() -> void:
	queue_free()
