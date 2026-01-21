extends Node2D

class_name ObjectMaker

const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.PLAYER_BULLET: preload("uid://bnuqog6euleuu"),
	Constants.ObjectType.ENEMY_BULLET: preload("uid://bdpaamkwcme0q"),
	Constants.ObjectType.EXPLOSION: preload("uid://khi532tiwte"),
	Constants.ObjectType.PICKUP: preload("uid://sgkbvkxfegt8"),
}

func _enter_tree() -> void:
	SignalHub.create_bullet_requested.connect(_on_create_bullet_requested)
	SignalHub.create_object_requested.connect(_on_create_object_requested)

func _on_create_bullet_requested(pos: Vector2, dir: Vector2, speed: float, obj_type: Constants.ObjectType) -> void:
	if not OBJECT_SCENES.has(obj_type):
		return

	var spawned_obj: BaseBullet = OBJECT_SCENES[obj_type].instantiate()
	spawned_obj.setup(pos, dir, speed)
	call_deferred("add_child", spawned_obj)

func _on_create_object_requested(pos: Vector2, obj_type: Constants.ObjectType) -> void:
	if not OBJECT_SCENES.has(obj_type):
		return

	var spawned_obj: Node2D = OBJECT_SCENES[obj_type].instantiate()
	spawned_obj.global_position = pos
	call_deferred("add_child", spawned_obj)
