extends Node2D

const ADD_OBJECT: String = "add_object"

const EXPLOSION_SCENE: PackedScene = preload("uid://bo7mfvx3jabwa")
const POWER_UP_SCENE: PackedScene = preload("uid://d3ot8sudqydmg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.create_explosion_requested.connect(_on_create_explosion_requested)
	SignalHub.create_power_up_requested.connect(_on_create_power_up_requested)

func add_object(obj: Node, pos: Vector2) -> void:
	add_child(obj)
	obj.global_position = pos

func _on_create_explosion_requested(pos: Vector2, animation_name: String) -> void:
	var explosion: Explosion = EXPLOSION_SCENE.instantiate()
	explosion.setup(animation_name)
	call_deferred(ADD_OBJECT, explosion, pos)

func _on_create_power_up_requested(pos: Vector2, type: PowerUp.PowerUpType) -> void:
	var power_up: PowerUp = POWER_UP_SCENE.instantiate()
	power_up.set_power_up_type(type)
	call_deferred(ADD_OBJECT, power_up, pos)
