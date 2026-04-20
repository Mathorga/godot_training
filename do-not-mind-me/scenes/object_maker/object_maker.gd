extends Node2D

const BULLET_SCENE: PackedScene = preload("uid://bl3aa5twetsum")
const BOOM_SCENE: PackedScene = preload("uid://541wc7llxpe3")

func _ready() -> void:
	SignalHub.bullet_spawn_requested.connect(_on_bullet_spawn_requested)
	SignalHub.boom_spawn_requested.connect(_on_boom_spawn_requested)

func _on_bullet_spawn_requested(pos: Vector2) -> void:
	var _bullet: Bullet = BULLET_SCENE.instantiate()
	_bullet.global_position = pos
	call_deferred("add_child", _bullet)

func _on_boom_spawn_requested(pos: Vector2) -> void:
	var _boom: Boom = BOOM_SCENE.instantiate()
	_boom.global_position = pos
	call_deferred("add_child", _boom)
	
