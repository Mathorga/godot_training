extends StaticBody2D

class_name Cup

static var cups_count: int = 0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var level_over_v_box: VBoxContainer = $MarginContainer/LevelOverVBox

func _ready() -> void:
	animation_player.animation_finished.connect(on_animation_finished)
	cups_count += 1

func vanish() -> void:
	animation_player.play("vanish")

func on_animation_finished(_anim_name: StringName) -> void:
	cups_count -= 1
	SignalHub.emit_cup_done(cups_count)
	queue_free()
