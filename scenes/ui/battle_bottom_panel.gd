extends Control

@export var item_scene: PackedScene
@export var width_ratio: float = 0.54    # Ширина панели (54% от ширины экрана)
@export var min_width: float = 400       # Минимальная ширина в пикселях
@export var height_pixels: float = 60    # Фиксированная высота в пикселях
@export var bottom_margin_pixels: float = 110  # Фиксированный отступ от низа в пикселях
@export var center_offset_ratio: float = 0.07 # Смещение от центра (7% вправо)
@export var item_margin: int = 10

@onready var items_container: HBoxContainer = $HBoxContainer/Background/Frame/ContentMargin/Scroller/ItemsContainer
@onready var scroller: ScrollContainer = %Scroller;

var current_item_size: float;
var currert_items: Array = ['']
var items_count: int = 35;


func _ready():
	_update_size()
	$HBoxContainer/LeftButton.disabled = true;
	$HBoxContainer/RightButton.disabled = true;
	_create_items()
	await get_tree().process_frame
	await get_tree().process_frame
	update_buttons_state()
	bind_signals()

func update_buttons_state():
	$HBoxContainer/RightButton.disabled = await is_scroll_at_end()
	$HBoxContainer/LeftButton.disabled = scroller.scroll_horizontal <= 0

func _update_size():
	var viewport = get_viewport_rect().size
	var panel_width = max(viewport.x * width_ratio, min_width)
	var panel_height = height_pixels
	var pos_y = viewport.y - panel_height - bottom_margin_pixels
	var pos_x = (viewport.x * 0.5) + (viewport.x * center_offset_ratio) - (panel_width * 0.5)

	size = Vector2(panel_width, panel_height)
	position = Vector2(pos_x, pos_y)

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


func add_item(item_data):
	var item = item_scene.instantiate()
	items_container.add_child(item)
	item.setup(item_data)

	var item_size = size.y - item_margin * 2 - 15
	item.custom_minimum_size = Vector2(item_size, item_size)

	current_item_size = item_size;
	return item

func clear_items():
	for item in items_container.get_children():
		item.queue_free()


func _create_items():
	clear_items()

	var user_items = UserStoreGlobal.get_skills()
	var need_empty_items_count = items_count - user_items.size();

	var epmty_items = get_empty_items_by_count(need_empty_items_count);
	var all_items = user_items + epmty_items;

	for item in all_items:
		add_item(item)


func get_empty_items_by_count(count : int) -> Array :
	var empty_items = [];
	var empty_item = { 'name': 'unnamed', 'path': '', 'id': 0, 'type': 'empty' };
	for i in range(count):
		empty_items.append(empty_item)

	return empty_items;


func bind_signals():
	get_tree().root.size_changed.connect(_update_size)
	scroller.gui_input.connect(_on_scroll_input)

func _on_scroll_input(event: InputEvent):
	if event is InputEventMouseButton:
		accept_event()


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

	var items_user_count = ItemStoreGlobal.get_all_items().size();
	var max_h_value_user_items = items_user_count * current_item_size;

	return scroller.scroll_horizontal >= (max_h_value_user_items - h_scrollbar.page - 0.1)
