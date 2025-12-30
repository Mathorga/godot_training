extends Resource

class_name ImageFilesListResource

@export var file_names: Array[String]

func add_file(file_name: String) -> void:
	if file_name.ends_with(".import"):
		return

	file_names.append(file_name)
