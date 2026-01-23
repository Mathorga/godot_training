class_name Utils

static func formatted_dt() -> String:
	var dt: Dictionary = Time.get_datetime_dict_from_system()
	return "%04d%02d%02d" % [
		dt.year,
		dt.month,
		dt.day
	]
