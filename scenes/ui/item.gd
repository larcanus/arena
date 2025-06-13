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

	# Если есть текст
	if is_instance_valid(label):
		label.text = text

	# Настройка размеров
	self.custom_minimum_size = Vector2(32, 32)  # Базовый размер
