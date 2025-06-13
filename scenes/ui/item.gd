extends Control

@onready var icon: TextureButton = $Icon
@onready var label: Label = $Label

func setup(texture_path: String, text: String = ""):
	if not is_instance_valid(icon):
		push_error("Icon node is invalid!")
		return

	# Загрузка текстуры
	var texture = load(texture_path)
	if not texture:
		push_error("Failed to load texture from path: ", texture_path)
		return

	# Назначение
	icon.texture = texture

	# Если есть текст
	if is_instance_valid(label):
		label.text = text

	# Настройка размеров
	self.custom_minimum_size = Vector2(64, 64)  # Базовый размер
