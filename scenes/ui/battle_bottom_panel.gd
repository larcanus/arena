extends Control

# Настройки
@export var item_scene: PackedScene # Перетащите сюда panel_item.tscn
@export var width_ratio: float = 0.54
@export var height_ratio: float = 0.1
@export var pos_x_ratio: float = 0.57
@export var pos_y_ratio: float = 0.95
@export var item_margin: int = 10 # Отступ между итемами

@onready var items_container: HBoxContainer = $HBoxContainer/Background/Frame/ContentMargin/Scroller/ItemsContainer
@onready var scroller: ScrollContainer = %Scroller;

var current_item_size: float;


func _ready():
	_update_size()
	get_tree().root.size_changed.connect(_update_size)
	$HBoxContainer/LeftButton.disabled = true;
	$HBoxContainer/RightButton.disabled = true;
	_create_demo_items() # Для теста
	await get_tree().process_frame
	await get_tree().process_frame
	update_buttons_state()

func update_buttons_state():
	$HBoxContainer/RightButton.disabled = await is_scroll_at_end()
	$HBoxContainer/LeftButton.disabled = scroller.scroll_horizontal <= 0

func _update_size():
	var viewport = get_viewport_rect().size
	var panel_width = viewport.x * width_ratio
	var panel_height = viewport.y * height_ratio

	size = Vector2(panel_width, panel_height)
	position = Vector2(
		viewport.x * pos_x_ratio - panel_width/2,
		viewport.y * pos_y_ratio - panel_height
	)

	_resize_items()

func _resize_items():
	var available_width = items_container.size.x - item_margin * 2
	var available_height = size.y - item_margin * 2 - 15  # Поправка по высоте

	var item_size = min(available_width, available_height)

	var items_per_row = max(1, floor(available_width / item_size))
	item_size = available_width / items_per_row  # Подгоняем под ширину

	for item in items_container.get_children():
		item.custom_minimum_size = Vector2(item_size, item_size)
		item.size = Vector2(item_size, item_size)

	current_item_size = item_size;
	update_buttons_state()


func add_item(svg_path: String, text: String = ""):
	var item = item_scene.instantiate()
	items_container.add_child(item)
	item.setup(svg_path, text)

	var item_size = size.y - item_margin * 2 - 15
	item.custom_minimum_size = Vector2(item_size, item_size)

	current_item_size = item_size;
	return item

func clear_items():
	for item in items_container.get_children():
		item.queue_free()


func _create_demo_items():
	clear_items()
	for i in 25:
		add_item("res://assets/graphics/icon.svg", "Item %d" % (i+1))

func _on_left_button_pressed() -> void:
	print(scroller.scroll_horizontal)
	var target_x = scroller.scroll_horizontal - current_item_size
	var tween = create_tween()

	tween.tween_property(scroller, "scroll_horizontal", target_x, 0.3)\
		 .set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	if scroller.scroll_horizontal == 0:
		$HBoxContainer/LeftButton.disabled = true;

	$HBoxContainer/RightButton.disabled = false;


func _on_right_button_pressed() -> void:
	var target_x = scroller.scroll_horizontal + current_item_size
	if target_x != 0:
		$HBoxContainer/LeftButton.disabled = false;

	var tween = create_tween()

	tween.tween_property(scroller, "scroll_horizontal", target_x, 0.3)\
		 .set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	if await is_scroll_at_end():
		$HBoxContainer/RightButton.disabled = true;

func is_scroll_at_end() -> bool:
	await get_tree().process_frame
	var h_scrollbar = scroller.get_h_scroll_bar()

	return scroller.scroll_horizontal >= (h_scrollbar.max_value - h_scrollbar.page - 0.1)
