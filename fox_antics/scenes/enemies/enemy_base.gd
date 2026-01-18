extends CharacterBody2D

class_name EnemyBase

const FALL_OFF_Y: int = 200

@export var points: int = 1
@export var speed: float = 50.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hit_box: Area2D = $HitBox

var gravity: Vector2 = Vector2(0.0, 981.0)
var player_ref: Player

func _ready() -> void:
	# Connect signals.
	visible_on_screen_notifier_2d.screen_entered.connect(on_screen_entered)
	hit_box.area_entered.connect(on_hitbox_area_entered)

	# Fetch the available player in the scene.
	player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)
	if player_ref == null:
		queue_free()

func _physics_process(_delta: float) -> void:
	if global_position.y > FALL_OFF_Y:
		queue_free()

func face_player() -> void:
	animated_sprite_2d.flip_h = player_ref.global_position.x > global_position.x

func die() -> void:
	set_physics_process(false)
	queue_free()

func on_screen_entered() -> void:
	pass

func on_hitbox_area_entered() -> void:
	die()
