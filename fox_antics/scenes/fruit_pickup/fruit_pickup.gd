extends Area2D

class_name FruitPickup

@export var points: int = 2

@onready var anim: AnimatedSprite2D = $Anim

func _enter_tree() -> void:
	area_entered.connect(_on_area_entered)

func _ready() -> void:
	var names: Array[String] = []

	for an_name in anim.sprite_frames.get_animation_names():
		names.append(an_name)

	anim.animation = names.pick_random()
	anim.play()

func _on_area_entered(_area: Area2D) -> void:
	queue_free()
