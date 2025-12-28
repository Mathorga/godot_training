extends Node2D


class_name Wizard


signal spell_cast


@onready var spell_timer: Timer = $SpellTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	show()


func _on_spell_timer_timeout() -> void:
	print("Spell was cast!")
	spell_cast.emit()

func kill_by_hobbit() -> void:
	spell_timer.stop()
	scale *= 0.5
