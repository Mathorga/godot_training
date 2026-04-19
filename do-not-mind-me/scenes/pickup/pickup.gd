extends Area2D
class_name Pickup

const GROUP_NAME: String = "PICKUP"

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)
	body_entered.connect(_on_body_entered)

func _ready() -> void:
	audio_stream_player_2d.finished.connect(_on_audio_finished)

func _on_body_entered(body: Node2D) -> void:
	set_deferred("monitoring", false)
	hide()
	audio_stream_player_2d.play()
	SignalHub.emit_pickup_collected()

func _on_audio_finished() -> void:
	queue_free()
