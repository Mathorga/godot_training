extends Node2D

const ADD_OBJECT: String = "add_object"

const EXPLOSION_SCENE: PackedScene = preload("uid://bo7mfvx3jabwa")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.create_explosion_requested.connect(_on_create_explosion_requested)

func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos

func _on_create_explosion_requested(pos: Vector2, animation_name: String) -> void:
	var explosion: Explosion = EXPLOSION_SCENE.instantiate()
	explosion.setup(animation_name)
	call_deferred(ADD_OBJECT, explosion, pos)
