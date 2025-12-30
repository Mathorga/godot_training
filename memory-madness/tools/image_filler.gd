@tool
extends EditorScript

## Creates a new resource holding all needed images so that they can be referenced even after deploy.
class_name ImageFiller

const IMAGES_PATH: String = "res://assets/glitch/"
const RESOURCE_PATH: String = "res://resources/image_files_list.tres"

func _run() -> void:
	var dir: DirAccess = DirAccess.open(IMAGES_PATH)
	var ifl_resource: ImageFilesListResource = ImageFilesListResource.new()
	
	if dir == null:
		return

	var files: PackedStringArray = dir.get_files()
	for file in files:
		ifl_resource.add_file(IMAGES_PATH + file)

	ResourceSaver.save(ifl_resource, RESOURCE_PATH)
