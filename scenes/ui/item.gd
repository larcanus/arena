extends Control

@onready var icon: TextureButton = $Icon
@onready var label: Label = $Label

var item_data: RefCounted;


func setup(item):
	if not is_instance_valid(icon):
		push_error("Panel item::Icon node is invalid!")
		return

	if item.path == '':
		print("Panel item::add empty item")
		return

	item_data = item;

	var texture = load(item_data.path)
	if not texture:
		push_error("Panel item::Failed to load texture from path: ", item_data.path)
		return

	icon.texture_normal = texture
	icon.texture_pressed = texture

	if is_instance_valid(label):
		label.text = item_data.name

	self.custom_minimum_size = Vector2(32, 32)


func _on_icon_pressed() -> void:
	print('Panel item::_on_icon_pressed type: ' + item_data.type)

	if not item_data.type == 'empty':
		animate_icon_click()

	BattleStoreGlobal.state_controller.update_selected_skill(item_data.id)







var is_animating = false
func animate_icon_click():
	if is_animating:
		return

	is_animating = true
	var tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	var click_scale = Vector2(0.85, 0.85)
	var original_pos = icon.position
	var original_scale = icon.scale
	var offset = (icon.size * (1.0 - click_scale.x)) / 2

	tween.tween_property(icon, "scale", click_scale, 0.06)
	tween.parallel().tween_property(icon, "position", original_pos + offset, 0.06)

	tween.tween_property(icon, "scale", original_scale, 0.06)
	tween.parallel().tween_property(icon, "position", original_pos, 0.06)

	tween.finished.connect(func(): is_animating = false)
