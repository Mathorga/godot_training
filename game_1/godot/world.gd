extends Node2D


@onready var hobbit: Hobbit = $Hobbit
@onready var wizard: Wizard = $Wizard


func _ready() -> void:
	hobbit.wizard_killed.connect(_on_hobbit_wizard_killed)

func _on_wizard_spell_cast() -> void:
	hobbit.hit_by_spell()

func _on_hobbit_wizard_killed() -> void:
	wizard.kill_by_hobbit()
