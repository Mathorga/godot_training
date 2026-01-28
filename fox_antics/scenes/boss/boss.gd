extends Node2D

class_name Boss

@export var lives: int = 3
@export var points: int = 5

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var trigger: Area2D = $Trigger
@onready var hit_box: Area2D = $Visuals/HitBox
@onready var shooter: Shooter = $Visuals/Shooter
@onready var state_machine: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var visuals: Node2D = $Visuals

var _invincible: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger.area_entered.connect(_on_triggered_by)
	hit_box.area_entered.connect(_on_hit_by)

func activate_collisions() -> void:
	hit_box.set_deferred("monitoring", true)
	hit_box.set_deferred("monitorable", true)

func shoot() -> void:
	var player: Player = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)

	if player == null:
		return

	shooter.shoot(shooter.global_position.direction_to(player.global_position))

func tween_hit() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(visuals, "position", Vector2.ZERO, 1.5)

func reduce_lives() -> void:
	lives -= 1

	if lives <= 0:
		SignalHub.emit_scored(points)
		queue_free()

func set_invincible(on: bool) -> void:
	_invincible = on

func take_damage() -> void:
	if _invincible:
		return

	set_invincible(true)
	state_machine.travel("hit")
	tween_hit()
	reduce_lives()

func _on_triggered_by(_area: Area2D) -> void:
	animation_tree["parameters/conditions/on_trigger"] = true

func _on_hit_by(_area: Area2D) -> void:
	take_damage()
