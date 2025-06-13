extends Control

@onready var icon: TextureButton = $Icon
@onready var label: Label = $Label


func setup(texture_path: String, text: String = ""):
	print('Panel item::setup' + texture_path)
	if not is_instance_valid(icon):
		push_error("Panel item::Icon node is invalid!")
		return

	# Загрузка текстуры
	var texture = load(texture_path)
	if not texture:
		push_error("Panel item::Failed to load texture from path: ", texture_path)
		return

	# Назначение
	icon.texture_normal = texture
	icon.texture_pressed = texture

	# Если есть текст
	if is_instance_valid(label):
		label.text = text

	# Настройка размеров
	self.custom_minimum_size = Vector2(32, 32)  # Базовый размер


func _on_icon_pressed() -> void:
	print('_on_icon_pressed') # Replace with function body.
	animate_icon_click()



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

	tween.finished.connect(func(): is_animating = false)  # Разблокируем после завершения
