extends Control
class_name GameUI

@onready var health_bar: HealthBar = $ColorRect/MarginContainer/HealthBar
@onready var sound: AudioStreamPlayer = $Sound

func _enter_tree() -> void:
	SignalHub.player_hit.connect(_on_player_hit)
	SignalHub.player_health_restored.connect(_on_player_health_restored)

func _ready() -> void:
	health_bar.died.connect(_on_player_died)

func _on_player_hit(damage: int) -> void:
	health_bar.update_value(-damage)

func _on_player_health_restored(val: int) -> void:
	health_bar.update_value(val)
	sound.play()

func _on_player_died() -> void:
	print("PLAYER DIED")
