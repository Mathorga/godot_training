extends Area2D

class_name Water

@onready var splash_sound: AudioStreamPlayer2D = $SplashSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(on_body_entered)

func on_body_entered(body: Node2D) -> void:
	splash_sound.position = body.position
	splash_sound.play()
