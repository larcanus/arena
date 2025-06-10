extends Control

@export var item_scene: PackedScene
@export var items_data: Array = []

# Относительные размеры (0.7 ширины экрана, 0.1 высоты)
@export var width_ratio: float = 0.6
@export var height_ratio: float = 0.1

# Относительное позиционирование (0.60 = 28% от центра, 0.95 = 5% от низа)
@export var pos_x_ratio: float = 0.60
@export var pos_y_ratio: float = 0.95

#@onready var items_container: HBoxContainer = $ItemsContainer
#@onready var scroll_container: ScrollContainer = $Scroller

var items: Array = []

func _ready():
	_update_size()
	get_tree().root.size_changed.connect(_update_size)
	create_items()

func _update_size():
	var viewport = get_viewport_rect().size

	# Устанавливаем размеры
	var panel_width = viewport.x * width_ratio
	var panel_height = viewport.y * height_ratio
	custom_minimum_size = Vector2(panel_width, panel_height)
	size = Vector2(panel_width, panel_height)

	# Позиционируем панель
	var pos_x = viewport.x * pos_x_ratio - panel_width/2
	var pos_y = viewport.y * pos_y_ratio - panel_height
	position = Vector2(pos_x, pos_y)

	# Обновляем пустой элемент (если есть)
	#_update_empty_item()

#func _update_empty_item():
	#if items_data.is_empty() and items_container.get_child_count() == 1:
		#var empty = items_container.get_child(0)
		#empty.custom_minimum_size = Vector2(
			#custom_minimum_size.x - 40,
			#custom_minimum_size.y - 40
		#)

func create_items():
	clear_items()

	if items_data.is_empty():
		var empty = Control.new()
		empty.custom_minimum_size = Vector2(
			custom_minimum_size.x - 40,
			custom_minimum_size.y - 40
		)
		#items_container.add_child(empty)
	else:
		for item_data in items_data:
			var item = item_scene.instantiate()
			#items_container.add_child(item)
			item.setup(item_data)
			items.append(item)

func clear_items():
	for item in items:
		if is_instance_valid(item) and item.is_inside_tree():
			item.queue_free()
	items.clear()

	#if is_instance_valid(items_container):
		#for child in items_container.get_children():
			#if is_instance_valid(child):
				#child.queue_free()

func update_panel(new_items: Array):
	items_data = new_items
	create_items()
	await get_tree().process_frame
	#if is_instance_valid(scroll_container):
		#scroll_container.scroll_horizontal = 0
