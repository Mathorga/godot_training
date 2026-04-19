extends Control
class_name GameUI

var _pickups_count: int = 0
var _collected_pickups: int = 0

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		GameManager.load_main_scene()
		return

func _ready() -> void:
	SignalHub.pickup_collected.connect(_on_pickup_collected)
	_pickups_count = get_tree().get_node_count_in_group(Pickup.GROUP_NAME)

func _on_pickup_collected() -> void:
	_collected_pickups += 1

	if _collected_pickups >= _pickups_count:
		SignalHub.request_show_exit()
