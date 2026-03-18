extends Area2D
class_name Player

const GROUP_NAME: String = "Player"

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var shield: Shield = $Shield

func _enter_tree() -> void:
	add_to_group(GROUP_NAME)
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is PowerUp:
		match area.get_power_up_type():
			PowerUp.PowerUpType.shield:
				shield.enable()
