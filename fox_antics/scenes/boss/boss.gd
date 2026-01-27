extends Node2D

class_name Boss

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var trigger: Area2D = $Trigger
@onready var hit_box: Area2D = $Visuals/HitBox
@onready var shooter: Shooter = $Visuals/Shooter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger.area_entered.connect(_on_area_entered)

func activate_collisions() -> void:
	hit_box.set_deferred("monitoring", true)
	hit_box.set_deferred("monitorable", true)

func shoot() -> void:
	var player: Player = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)

	if player == null:
		return

	shooter.shoot(shooter.global_position.direction_to(player.global_position))

func _on_area_entered(_area: Area2D) -> void:
	animation_tree["parameters/conditions/on_trigger"] = true
