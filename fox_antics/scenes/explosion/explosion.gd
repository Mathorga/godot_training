extends AnimatedSprite2D

class_name Explosion

@onready var sound: AudioStreamPlayer2D = $Sound

func _enter_tree() -> void:
	animation_finished.connect(_on_animation_finished)

func _ready() -> void:
	sound.finished.connect(_on_sound_finished)
	sound.play()

func _on_animation_finished() -> void:
	hide()

func _on_sound_finished() -> void:
	queue_free()
