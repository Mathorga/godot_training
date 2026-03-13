extends Node2D

const ADD_OBJECT: String = "add_object"

const EXPLOSION_SCENE: PackedScene = preload("uid://bo7mfvx3jabwa")
const POWER_UP_SCENE: PackedScene = preload("uid://d3ot8sudqydmg")
const PLAYER_BULLET_SCENE: PackedScene = preload("uid://n32rvo6iicrg")
const ENEMY_BULLET_SCENE: PackedScene = preload("uid://c8c0gq8xyjdp")
const BOMB_SCENE: PackedScene = preload("uid://dofw4s4kxtn8c")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.create_explosion_requested.connect(_on_create_explosion_requested)
	SignalHub.create_power_up_requested.connect(_on_create_power_up_requested)
	SignalHub.create_bullet_requested.connect(_on_create_bullet_requested)

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

func _on_create_bullet_requested(pos: Vector2, dir: Vector2, speed: float, type: BulletBase.BulletType) -> void:
	var bullet_scene: PackedScene
	match type:
		BulletBase.BulletType.player:
			bullet_scene = PLAYER_BULLET_SCENE
		BulletBase.BulletType.enemy:
			bullet_scene = ENEMY_BULLET_SCENE
		BulletBase.BulletType.bomb:
			bullet_scene = BOMB_SCENE

	var bullet: BulletBase = bullet_scene.instantiate()
	bullet.setup(dir, speed)
	call_deferred(ADD_OBJECT, bullet, pos)
