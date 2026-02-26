extends Projectile
class_name PowerUp

enum PowerUpType {
	health,
	shield
}

const SPEED: float = 80.0
const TEXTURES: Dictionary[PowerUpType, Resource] = {
	PowerUpType.health: preload("uid://corto2r4s6dis"),
	PowerUpType.shield: preload("uid://bcy8wtnoerd3r")
}

@onready var sprite_2d: Sprite2D = $Sprite2D

var _power_up_type: PowerUpType = PowerUpType.shield

func _ready() -> void:
	sprite_2d.texture = TEXTURES[_power_up_type]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_power_up_type() -> PowerUpType:
	return _power_up_type

func set_power_up_type(power_up_type: PowerUpType) -> void:
	_power_up_type = power_up_type
