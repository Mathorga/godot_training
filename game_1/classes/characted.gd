extends Object


class_name Character


var _name: String
var _weapon: String


#var health: int:
	#get = get_health,
	#set = set_health

var health: int:
	get:
		return health
	set(value):
		health = clampi(value, 0, 100)


func _init(
	p_health: int,
	p_name: String,
	p_weapon: String
) -> void:
	self.health = p_health
	_name = p_name
	_weapon = p_weapon


func _to_string() -> String:
	return "%s health: %d weapon: %s" % [
		_name,
		health,
		_weapon
	]


func print_info() -> void:
	print(self)

func attack() -> void:
	print("%s attacked with %s" % [
		_name,
		_weapon
	])
