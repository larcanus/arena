extends Control

# Настройки
@export var item_scene: PackedScene # Перетащите сюда panel_item.tscn
@export var width_ratio: float = 0.6
@export var height_ratio: float = 0.1
@export var pos_x_ratio: float = 0.6
@export var pos_y_ratio: float = 0.95
@export var item_margin: int = 10 # Отступ между итемами

@onready var items_container: HBoxContainer = $Background/Frame/ContentMargin/Scroller/ItemsContainer

func _ready():
	_update_size()
	get_tree().root.size_changed.connect(_update_size)
	_create_demo_items() # Для теста

func _update_size():
	var viewport = get_viewport_rect().size
	var panel_width = viewport.x * width_ratio
	var panel_height = viewport.y * height_ratio

	size = Vector2(panel_width, panel_height)
	position = Vector2(
		viewport.x * pos_x_ratio - panel_width/2,
		viewport.y * pos_y_ratio - panel_height
	)

	# Обновляем размеры итемов
	_resize_items()

func _resize_items():
	var available_width = items_container.size.x - item_margin * 2
	var available_height = size.y - item_margin * 2 - 15  # Поправка по высоте

	# Предполагаем, что итемы должны быть квадратными
	var item_size = min(available_width, available_height)

	# Если итемы могут переноситься на новую строку, учитываем их количество
	var items_per_row = max(1, floor(available_width / item_size))
	item_size = available_width / items_per_row  # Подгоняем под ширину

	for item in items_container.get_children():
		item.custom_minimum_size = Vector2(item_size, item_size)
		item.size = Vector2(item_size, item_size)

func add_item(svg_path: String, text: String = ""):
	var item = item_scene.instantiate()
	items_container.add_child(item)
	item.setup(svg_path, text)

	# Устанавливаем квадратный размер
	var item_size = size.y - item_margin * 2 - 15
	item.custom_minimum_size = Vector2(item_size, item_size)

	return item

func clear_items():
	for item in items_container.get_children():
		item.queue_free()

# Тестовая функция (потом удалите)
func _create_demo_items():
	clear_items()
	for i in 50:
		add_item("res://assets/graphics/icon.svg", "Item %d" % (i+1))
