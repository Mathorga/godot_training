extends TextureButton

class_name MemoryTile

@onready var frame_image: TextureRect = $FrameImage
@onready var item_image: TextureRect = $ItemImage

#region overrides

func _enter_tree() -> void:
	pressed.connect(on_pressed)

func _ready() -> void:
	reveal(false)

#endregion

func setup(item: Texture2D, frame: Texture2D) -> void:
	frame_image.texture = frame
	item_image.texture = item

func reveal(r: bool) -> void:
	frame_image.visible = r
	item_image.visible = r

func matches(other: MemoryTile) -> bool:
	return self != other and item_image.texture == other.item_image.texture

func kill() -> void:
	z_index = 1
	var tween: Tween = create_tween()
	tween.tween_property(self, "disabled", true, 0.0)
	tween.tween_property(self, "rotation", PI * 2, 0.5).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(self, "scale", Vector2(1.5, 1.5), 0.5).set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(self, "rotation", PI * 4, 0.5).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property(self, "scale", Vector2.ZERO, 0.5).set_trans(Tween.TRANS_SINE)

#region signal_callbacks

func on_pressed() -> void:
	if not Scorer.selection_enabled:
		return

	SignalHub.emit_tile_selected(self)

#endregion
