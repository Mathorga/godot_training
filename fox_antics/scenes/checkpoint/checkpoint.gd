extends Area2D

@onready var sound: AudioStreamPlayer2D = $Sound
@onready var animation_tree: AnimationTree = $AnimationTree

var _boss_killed: bool = false

func _enter_tree() -> void:
	area_entered.connect(_on_area_entered)

func _ready() -> void:
	SignalHub.boss_killed.connect(_on_boss_killed)
	animation_tree.animation_finished.connect(_on_animation_finished)

func _on_area_entered(_area: Area2D) -> void:
	print("CAVERNONE")

func _on_boss_killed() -> void:
	_boss_killed = true

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "open":
		set_deferred("monitoring", true)
