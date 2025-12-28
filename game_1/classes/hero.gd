extends Character


class_name Hero


var _ability: String = "ability"


func _init(
	p_health: int,
	p_name: String,
	p_weapon: String,
	p_ability: String
) -> void:
	super(p_health, p_name, p_weapon)
	_ability = p_ability


func use_ability() -> void:
	print("%s used ability %s" % [
		_name,
		_ability
	])

func attack() -> void:
	print("Hero %s attacked with %s and %s" % [
		_name,
		_weapon,
		_ability
	])
